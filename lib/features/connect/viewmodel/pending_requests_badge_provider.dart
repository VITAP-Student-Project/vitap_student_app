import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:vit_ap_student_app/core/models/user.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';
import 'package:vit_ap_student_app/objectbox.g.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';

part 'pending_requests_badge_provider.g.dart';

@Riverpod(keepAlive: true)
class PendingRequestsBadge extends _$PendingRequestsBadge {
  RealtimeChannel? _channel;

  @override
  int build() {
    // Rebuild/reset when the user logs in or out
    final user = ref.watch(currentUserProvider);
    if (user == null) {
      _cleanup();
      return 0;
    }
    
    _fetchCount();
    _setupSubscription();
    
    return 0; // Default until fetch completes
  }

  void _cleanup() {
    _channel?.unsubscribe();
    _channel = null;
  }

  Future<void> _fetchCount() async {
    try {
      final userBox = serviceLocator<Store>().box<User>();
      final dbUser = userBox.query().build().findFirst();
      final myRegNo = dbUser?.profile.target?.registrationNumber ?? '';
      
      if (myRegNo.isEmpty) return;

      final countRes = await Supabase.instance.client
          .from('friendships')
          .select('id')
          .eq('user_b_id', myRegNo)
          .eq('status', 'pending')
          .count(CountOption.exact);
      
      state = countRes.count ?? 0;
    } catch (e) {
      // Ignore network errors silently
    }
  }

  void _setupSubscription() {
    if (_channel != null) return;
    
    _channel = Supabase.instance.client.channel('public:friendships_badge');
    _channel!.onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: 'public',
      table: 'friendships',
      callback: (payload) {
        // Any insert/update/delete on friendships triggers a recount
        _fetchCount();
      },
    ).subscribe();

    ref.onDispose(() {
      _cleanup();
    });
  }
}
