import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/models/profile.dart';
import 'package:vit_ap_student_app/core/models/user.dart';
import 'package:vit_ap_student_app/core/services/secure_store_service.dart';
import 'package:vit_ap_student_app/features/connect/data/repositories/supabase_repository.dart';
import 'dart:convert';
import 'package:vit_ap_student_app/init_dependencies.dart';
import 'package:vit_ap_student_app/objectbox.g.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:shared_preferences/shared_preferences.dart';

part 'connect_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class ConnectViewModel extends _$ConnectViewModel {
  String _getMyRegNo() {
    final userBox = serviceLocator<Store>().box<User>();
    final user = userBox.query().build().findFirst();
    return user?.profile.target?.registrationNumber ?? '';
  }

  @override
  FutureOr<Map<String, dynamic>> build() async {
    final myRegNo = _getMyRegNo();
    await _checkOptInStatus(myRegNo);
    _setupRealtimeSubscription();
    
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('connect_dashboard_cache_$myRegNo');
    
    if (cachedData != null) {
      try {
        final data = jsonDecode(cachedData) as Map<String, dynamic>;
        // Perform silent background refresh
        Future(() async {
          try {
            final freshData = await _fetchFriendsData();
            state = AsyncData(freshData);
          } catch (e) {
            // Ignore error on background sync
          }
        });
        return data;
      } catch (e) {
        // Cache corrupted, fallback to normal fetch
      }
    }
    // If there is no cache (e.g. first launch after install), do NOT block the UI for 13 seconds!
    // Start the fetch in the background
    Future(() async {
      try {
        final freshData = await _fetchFriendsData();
        state = AsyncData(freshData);
      } catch (e, st) {
        state = AsyncError(e, st);
      }
    });

    // Return an instant empty dashboard so the user doesn't stare at a spinner
    final pin = prefs.getString('connect_pin_$myRegNo') ?? '';
    return {
      'friends': [],
      'pending': [],
      'pendingOutgoing': [],
      'myPin': pin,
      'myRegNo': myRegNo,
    };
  }

  void _setupRealtimeSubscription() {
    final client = Supabase.instance.client;
    final channel = client.channel('public:friendships');
    
    channel.onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: 'public',
      table: 'friendships',
      callback: (payload) {
        // Automatically refresh data in the background when DB changes!
        refresh();
      },
    ).subscribe();

    ref.onDispose(() {
      client.removeChannel(channel);
    });
  }

  Future<void> _checkOptInStatus(String myRegNo) async {
    final prefs = await SharedPreferences.getInstance();
    final pin = prefs.getString('connect_pin_$myRegNo');
    if (pin == null || pin.isEmpty) {
      throw Exception('Not opted in');
    }
  }

  Future<Map<String, dynamic>> _fetchFriendsData() async {
    final repository = serviceLocator<SupabaseRepository>();
    
    // Fetch all data concurrently with a 7-second timeout
    final results = await Future.wait([
      repository.getFriends(),
      repository.getPendingRequests(),
      repository.getPendingOutgoingRequests(),
    ]).timeout(
      const Duration(seconds: 5),
      onTimeout: () => throw Exception('Network timeout. Please check your connection.'),
    );

    final friends = results[0];
    final pending = results[1];
    final pendingOutgoing = results[2];
    
    final myRegNo = _getMyRegNo();
    
    final prefs = await SharedPreferences.getInstance();
    
    // --- 24-HOUR SILENT PIN SYNC ---
    final lastPinSyncStr = prefs.getString('connect_pin_last_sync_$myRegNo');
    final lastPinSync = lastPinSyncStr != null ? DateTime.tryParse(lastPinSyncStr) : null;
    
    if (lastPinSync == null || DateTime.now().difference(lastPinSync).inHours >= 24) {
      final remotePin = await repository.fetchPinFromSupabase(myRegNo).timeout(
        const Duration(seconds: 5),
        onTimeout: () => null, // Ignore timeout on background pin sync
      );
      if (remotePin != null && remotePin.isNotEmpty) {
        await prefs.setString('connect_pin_$myRegNo', remotePin);
      }
      await prefs.setString('connect_pin_last_sync_$myRegNo', DateTime.now().toIso8601String());
    }
    // -------------------------------

    final pin = prefs.getString('connect_pin_$myRegNo') ?? '';

    final data = {
      'friends': friends,
      'pending': pending,
      'pendingOutgoing': pendingOutgoing,
      'myPin': pin,
      'myRegNo': myRegNo,
    };

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('connect_dashboard_cache_$myRegNo', jsonEncode(data));
    } catch (e) {
      // Ignore cache write errors
    }

    return data;
  }

  Future<void> refresh() async {
    try {
      await _checkOptInStatus(_getMyRegNo());
      final data = await _fetchFriendsData();
      state = AsyncData(data); // Silent update (no loading spinner)
    } catch (e, st) {
      if (!state.hasValue) {
        state = AsyncError(e, st);
      }
    }
  }

  Future<void> optIn() async {
    state = const AsyncValue.loading();
    
    // Optimistic UI: Transition instantly
    state = await AsyncValue.guard(() async {
      final repository = serviceLocator<SupabaseRepository>();
      
      // We don't await the network call! We let it run in the background.
      Future(() async {
        try {
          await repository.optInAndSync().timeout(const Duration(seconds: 15));
          // Once upload succeeds, fetch real friends data silently
          final freshData = await _fetchFriendsData();
          state = AsyncData(freshData);
        } catch (e) {
          // If network completely fails, we could revert state, but for now
          // they'll just retry later. The PIN is saved locally.
        }
      });
      
      // Instantly generate and save PIN locally so UI can proceed
      await repository.optInLocalOnly();

      // Return empty dashboard instantly to unblock the UI spinner
      return {
        'friends': [],
        'pending': [],
        'pendingOutgoing': [],
      };
    });
  }

  Future<void> regeneratePin() async {
    try {
      final repository = serviceLocator<SupabaseRepository>();
      await repository.regeneratePin().timeout(
        const Duration(seconds: 7),
        onTimeout: () => throw Exception('Network timeout. Try again.'),
      );
      final data = await _fetchFriendsData();
      state = AsyncData(data); // Silent update
    } catch (e, st) {
      if (!state.hasValue) {
        state = AsyncError(e, st);
      }
    }
  }
}
