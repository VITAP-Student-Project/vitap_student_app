import 'dart:math';
import 'package:uuid/uuid.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vit_ap_student_app/core/models/profile.dart';
import 'package:vit_ap_student_app/core/models/user.dart' as local_model;
import 'package:vit_ap_student_app/core/models/timetable.dart';
import 'package:vit_ap_student_app/core/services/secure_store_service.dart';
import 'package:vit_ap_student_app/objectbox.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupabaseRepository {
  final SupabaseClient _client;
  final SecureStorageService _secureStorage;
  final Store _store;

  SupabaseRepository(this._client, this._secureStorage, this._store);

  /// Generates a random 6-digit PIN
  String _generatePin() {
    final random = Random();
    final pin = random.nextInt(900000) + 100000; // 100000 to 999999
    return pin.toString();
  }

  /// Fetches the user's latest PIN directly from Supabase
  Future<String?> fetchPinFromSupabase(String regNo) async {
    try {
      final secret = await _getOrGenerateDeviceSecret();
      final res = await _client.rpc('get_my_pin', params: {
        'p_reg_no': regNo,
        'p_secret': secret,
      }).maybeSingle();
      if (res != null) {
        return res['unique_pin']?.toString();
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  /// Updates the user's FCM token in Supabase for push notifications
  Future<void> updateFcmToken(String token) async {
    try {
      final myRegNo = await _getMyRegNo();
      if (myRegNo == null) return;
      final secret = await _getOrGenerateDeviceSecret();
      await _client.rpc('update_fcm_token', params: {
        'p_reg_no': myRegNo,
        'p_secret': secret,
        'p_token': token,
      });
    } catch (e) {
      // Ignore network errors during token update
    }
  }

  /// Helper to get current user registration number from ObjectBox
  Future<String?> _getMyRegNo() async {
    final userBox = _store.box<local_model.User>();
    final user = userBox.query().build().findFirst();
    return user?.profile.target?.registrationNumber;
  }

  Future<String> _getOrGenerateDeviceSecret() async {
    String? secret = await _secureStorage.getDeviceSecret();
    if (secret == null || secret.isEmpty) {
      secret = const Uuid().v4();
      await _secureStorage.saveDeviceSecret(secret);
    }
    return secret;
  }

  /// Opt-in logic: scrapes RegNo and Timetable from ObjectBox,
  /// generates a 6-digit PIN, and safely uploads it to Supabase.
  Future<void> optInAndSync() async {
    // 1. Get Profile from ObjectBox to find the Registration Number
    final userBox = _store.box<local_model.User>();
    final user = userBox.query().build().findFirst();
    final profile = user?.profile.target;

    if (profile == null || profile.registrationNumber.isEmpty) {
      throw Exception('Registration number not found. Please re-login to VTOP first.');
    }

    final regNo = profile.registrationNumber;
    final name = profile.studentName;

    // 2. Get Timetable from ObjectBox
    final timetable = user?.timetable.target;

    if (timetable == null) {
      throw Exception('Timetable not found. Please open your timetable in the app to sync it locally.');
    }

    final timetableJson = timetable.toJson();

    // 3. Generate the random "Use and Throw" PIN
    final pin = _generatePin();

    // 4. Upload to Supabase using the secure RPC
    final secret = await _getOrGenerateDeviceSecret();
    await _client.rpc('opt_in_user', params: {
      'p_reg_no': regNo,
      'p_name': name,
      'p_timetable': timetableJson,
      'p_pin': pin,
      'p_secret': secret,
      'p_time': DateTime.now().toIso8601String(),
    });

    // 5. Only save PIN to local storage AFTER successful upload
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('connect_pin_${profile.registrationNumber}', pin);
  }

  /// Optimistic helper: Immediately creates and saves the PIN locally
  Future<void> optInLocalOnly() async {
    final userBox = _store.box<local_model.User>();
    final user = userBox.query().build().findFirst();
    final profile = user?.profile.target;
    if (profile == null || profile.registrationNumber.isEmpty) return;

    final pin = _generatePin();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('connect_pin_${profile.registrationNumber}', pin);
  }

  /// "Use and Throw" Logic: Destroys old PIN and uploads a new one
  Future<void> regeneratePin() async {
    final userBox = _store.box<local_model.User>();
    final user = userBox.query().build().findFirst();
    final profile = user?.profile.target;

    if (profile == null || profile.registrationNumber.isEmpty) {
      throw Exception('Registration number not found.');
    }

    final newPin = _generatePin();

    // 1. Update the database first using the secure RPC
    final secret = await _getOrGenerateDeviceSecret();
    await _client.rpc('regenerate_pin', params: {
      'p_reg_no': profile.registrationNumber,
      'p_secret': secret,
      'p_new_pin': newPin,
    });

    // 2. Save locally
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('connect_pin_${profile.registrationNumber}', newPin);
  }

  /// Sends a friend request using the atomic Race-Condition lock
  Future<void> sendFriendRequest({
    required String targetRegNo,
    required String enteredPin,
  }) async {
    final userBox = _store.box<local_model.User>();
    final user = userBox.query().build().findFirst();
    final profile = user?.profile.target;
    if (profile == null || profile.registrationNumber.isEmpty) {
      throw Exception('Registration number not found.');
    }
    final myRegNo = profile.registrationNumber;

    final String formattedTarget = targetRegNo.trim().toUpperCase();

    if (formattedTarget.length > 12 || formattedTarget.isEmpty) {
      throw Exception('Invalid Registration Number format.');
    }

    if (myRegNo == formattedTarget) {
      throw Exception('You cannot send a friend request to yourself.');
    }

    final secret = await _getOrGenerateDeviceSecret();
    
    try {
      await _client.rpc('send_friend_request', params: {
        'p_sender_reg': myRegNo,
        'p_sender_secret': secret,
        'p_target_reg': formattedTarget,
        'p_target_pin': enteredPin,
      });
    } catch (e) {
      if (e.toString().contains('Incorrect PIN')) {
        throw Exception('Incorrect PIN or the user recently regenerated it.');
      }
      throw Exception('Failed to send request. You may already be friends or sent a request.');
    }
  }

  /// Accepts a friend request
  Future<void> acceptFriendRequest({
    required String senderRegNo,
  }) async {
    final userBox = _store.box<local_model.User>();
    final user = userBox.query().build().findFirst();
    final profile = user?.profile.target;
    if (profile == null || profile.registrationNumber.isEmpty) {
      throw Exception('Registration number not found.');
    }
    final myRegNo = profile.registrationNumber;

    final String formattedSender = senderRegNo.trim().toUpperCase();

    if (formattedSender.length > 12 || formattedSender.isEmpty) {
      throw Exception('Invalid Registration Number format.');
    }

    final secret = await _getOrGenerateDeviceSecret();
    try {
      await _client.rpc('accept_friend_request', params: {
        'p_target_reg': myRegNo,
        'p_target_secret': secret,
        'p_sender_reg': formattedSender,
      });
    } catch (e) {
      throw Exception('Request no longer exists or unauthorized.');
    }
  }

  /// Revoke or delete a friendship automatically
  Future<void> removeFriend(String friendRegNo) async {
    final userBox = _store.box<local_model.User>();
    final user = userBox.query().build().findFirst();
    final profile = user?.profile.target;
    if (profile == null || profile.registrationNumber.isEmpty) return;
    final myRegNo = profile.registrationNumber;

    final String formattedFriend = friendRegNo.toUpperCase();

    final secret = await _getOrGenerateDeviceSecret();
    try {
      await _client.rpc('remove_friend', params: {
        'p_my_reg': myRegNo,
        'p_my_secret': secret,
        'p_other_reg': formattedFriend,
      });
    } catch (e) {
      // Ignore
    }
  }

  /// Streams the user's friendships (both pending and accepted)
  Stream<List<Map<String, dynamic>>> getFriendshipsStream() {
    final userBox = _store.box<local_model.User>();
    final user = userBox.query().build().findFirst();
    final profile = user?.profile.target;
    if (profile == null || profile.registrationNumber.isEmpty) {
      return Stream.value([]);
    }
    final myRegNo = profile.registrationNumber;

    return _client
        .from('friendships')
        .stream(primaryKey: ['id'])
        .eq('user_a_id', myRegNo)
        .order('created_at', ascending: false)
        .map((event) => event);
  }

  Future<List<dynamic>> getFriends() async {
    final userBox = _store.box<local_model.User>();
    final user = userBox.query().build().findFirst();
    final profile = user?.profile.target;
    if (profile == null || profile.registrationNumber.isEmpty) return [];
    final secret = await _getOrGenerateDeviceSecret();
    return await _client.rpc('get_my_friends', params: {
      'p_my_reg': profile.registrationNumber,
      'p_my_secret': secret,
    });
  }

  Future<List<dynamic>> getPendingRequests() async {
    final userBox = _store.box<local_model.User>();
    final user = userBox.query().build().findFirst();
    final profile = user?.profile.target;
    if (profile == null || profile.registrationNumber.isEmpty) return [];
    final secret = await _getOrGenerateDeviceSecret();
    return await _client.rpc('get_pending_incoming', params: {
      'p_my_reg': profile.registrationNumber,
      'p_my_secret': secret,
    });
  }

  Future<List<dynamic>> getPendingOutgoingRequests() async {
    final userBox = _store.box<local_model.User>();
    final user = userBox.query().build().findFirst();
    final profile = user?.profile.target;
    if (profile == null || profile.registrationNumber.isEmpty) return [];
    final secret = await _getOrGenerateDeviceSecret();
    return await _client.rpc('get_pending_outgoing', params: {
      'p_my_reg': profile.registrationNumber,
      'p_my_secret': secret,
    });
  }

  Future<void> cancelFriendRequest(String targetRegNo) async {
    final userBox = _store.box<local_model.User>();
    final user = userBox.query().build().findFirst();
    final profile = user?.profile.target;
    if (profile == null || profile.registrationNumber.isEmpty) return;
    
    final myRegNo = profile.registrationNumber;
    final String formattedTarget = targetRegNo.trim().toUpperCase();

    final secret = await _getOrGenerateDeviceSecret();
    try {
      await _client.rpc('remove_friend', params: {
        'p_my_reg': myRegNo,
        'p_my_secret': secret,
        'p_other_reg': formattedTarget,
      });
    } catch (e) {
      // Ignore
    }
  }
}
