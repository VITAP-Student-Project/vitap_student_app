import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/core/common/widget/loader.dart';
import 'package:vit_ap_student_app/core/models/timetable.dart';
import 'package:vit_ap_student_app/features/connect/view/pages/friend_timetable_page.dart';
import 'package:vit_ap_student_app/features/connect/view/pages/manage_friends_page.dart';
import 'package:vit_ap_student_app/features/connect/viewmodel/connect_viewmodel.dart';
import 'package:vit_ap_student_app/features/connect/data/repositories/supabase_repository.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';
import 'package:vit_ap_student_app/features/connect/utils/time_sync_calculator.dart';

class ConnectPage extends ConsumerWidget {
  const ConnectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectState = ref.watch(connectViewModelProvider);

    ref.listen<AsyncValue>(
      connectViewModelProvider,
      (_, state) {
        if (!state.isLoading && state.hasError) {
          String err = state.error.toString();
          if (err.contains('SocketException') || err.contains('ClientException') || err.contains('Failed host lookup')) {
            err = 'No internet connection. Please check your network and try again.';
          }
          // We ignore the default 'Not opted in' error from initial check
          if (!err.contains('Not opted in')) {
            showSnackBar(context, err.replaceAll('Exception: ', ''), SnackBarType.error);
          }
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TimeSync',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
      body: connectState.when(
        data: (data) => _ConnectDashboard(data: data),
        loading: () => const Loader(),
        error: (error, stackTrace) {
          String errStr = error.toString();
          if (errStr.contains('SocketException') || errStr.contains('ClientException') || errStr.contains('Failed host lookup')) {
            return _OptInScreen(errorMessage: 'No internet connection. Please check your network and try again.');
          }
          return const _OptInScreen();
        },
      ),
    );
  }
}

class _OptInScreen extends ConsumerStatefulWidget {
  final String? errorMessage;
  const _OptInScreen({this.errorMessage});

  @override
  ConsumerState<_OptInScreen> createState() => _OptInScreenState();
}

class _OptInScreenState extends ConsumerState<_OptInScreen> {
  bool _agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Iconsax.calendar,
              size: 80,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          if (widget.errorMessage != null) ...[
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                widget.errorMessage!,
                style: TextStyle(color: Theme.of(context).colorScheme.onError),
                textAlign: TextAlign.center,
              ),
            ),
          ],
          const SizedBox(height: 32),
          Text(
            'Welcome to TimeSync',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Securely share your timetable with friends and instantly find common free time. Protected by One-Time PINs.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: _agreedToTerms,
                  onChanged: (val) {
                    setState(() {
                      _agreedToTerms = val ?? false;
                    });
                  },
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Terms & Privacy'),
                          content: const SingleChildScrollView(
                            child: Text(
                                'By enabling TimeSync, you agree to share your schedule data with other users who have your unique PIN.\n\n'
                                'Your registration number and timetable will be stored securely on our servers. '
                                'You can generate a new PIN at any time to revoke access for new requests, or remove friends to stop sharing with them.'),
                          ),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))
                          ],
                        ),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodySmall,
                        children: [
                          const TextSpan(text: 'By agreeing, I accept the '),
                          TextSpan(
                            text: 'Terms & Conditions and Privacy Policy',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const TextSpan(text: ' for timetable sharing.'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton(
              onPressed: _agreedToTerms
                  ? () {
                      ref.read(connectViewModelProvider.notifier).optIn();
                    }
                  : null,
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Enable Connect', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConnectDashboard extends ConsumerWidget {
  final Map<String, dynamic> data;
  const _ConnectDashboard({required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friends = data['friends'] as List<dynamic>;
    final pending = data['pending'] as List<dynamic>;
    final myPin = data['myPin'] as String;
    final myRegNo = data['myRegNo'] as String;

    if (friends.isEmpty) {
      return _buildEmptyState(context, ref, myRegNo, myPin, pending);
    } else {
      return _buildActiveState(context, ref, friends, pending);
    }
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref, String myRegNo, String myPin, List<dynamic> pending) {
    return RefreshIndicator(
      onRefresh: () async => await ref.read(connectViewModelProvider.notifier).refresh(),
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (pending.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 32),
                      child: InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageFriendsPage())),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Iconsax.notification_copy, color: Theme.of(context).colorScheme.onPrimary, size: 20),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Pending Request!',
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'You have ${pending.length} new connection request(s).',
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(Iconsax.arrow_right_3_copy, color: Theme.of(context).colorScheme.onPrimaryContainer),
                            ],
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5)),
                    ),
                    child: Column(
                      children: [
                        Text('YOUR REG NO', style: Theme.of(context).textTheme.labelMedium),
                        const SizedBox(height: 4),
                        Text(myRegNo, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 24),
                        Text('YOUR ONE TIME PIN', style: Theme.of(context).textTheme.labelMedium),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              myPin,
                              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 8,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                            IconButton(
                              icon: const Icon(Iconsax.refresh_copy),
                              onPressed: () {
                                ref.read(connectViewModelProvider.notifier).regeneratePin();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 60),
                  Text(
                    'You haven\'t connected with anyone yet!',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Share your ONE TIME PIN with a friend, or request their timetable below.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton.icon(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageFriendsPage())),
                      icon: const Icon(Iconsax.user_add_copy),
                      label: const Text('Request Timetable', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActiveState(BuildContext context, WidgetRef ref, List<dynamic> friends, List<dynamic> pending) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => await ref.read(connectViewModelProvider.notifier).refresh(),
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          itemCount: friends.length,
          itemBuilder: (context, index) {
            final friend = friends[index];
            return Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    child: Text(
                      friend['name'].toString().substring(0, 1).toUpperCase(),
                      style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(friend['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Builder(
                    builder: (context) {
                      String statusText = 'Unknown Status';
                      bool isFree = false;
                      try {
                        final timetableJson = friend['timetable_json'] as Map<String, dynamic>;
                        final timetable = Timetable.fromJson(timetableJson);
                        statusText = TimeSyncCalculator.getCurrentStatus(timetable);
                        isFree = statusText.toLowerCase().contains('free');
                      } catch (e) {
                        statusText = 'Timetable unavailable';
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(friend['reg_no']),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: isFree 
                                  ? const Color(0xFFE8F5E9) 
                                  : Theme.of(context).colorScheme.errorContainer.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isFree ? const Color(0xFF81C784) : Theme.of(context).colorScheme.error,
                                width: 0.5,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: isFree ? const Color(0xFF4CAF50) : Theme.of(context).colorScheme.error,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  statusText,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: isFree 
                                        ? const Color(0xFF2E7D32) 
                                        : Theme.of(context).colorScheme.onErrorContainer,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  trailing: const Icon(Iconsax.arrow_right_3_copy),
                  onTap: () {
                    try {
                      final timetableJson = friend['timetable_json'] as Map<String, dynamic>;
                      final timetable = Timetable.fromJson(timetableJson);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FriendTimetablePage(
                            friendName: friend['name'] ?? 'Friend',
                            friendRegNo: friend['reg_no'] ?? '',
                            timetable: timetable,
                          ),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error loading timetable: $e')),
                      );
                    }
                  },
                  onLongPress: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Remove Friend?'),
                        content: Text('Are you sure you want to stop syncing with ${friend['name']}?'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                          FilledButton(
                            onPressed: () => Navigator.pop(context, true), 
                            style: FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
                            child: const Text('Remove'),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      try {
                        final repo = serviceLocator<SupabaseRepository>();
                        await repo.removeFriend(friend['reg_no']);
                        ref.read(connectViewModelProvider.notifier).refresh();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Friend removed')));
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                        }
                      }
                    }
                  },
                ),
            );
          },
        ),
      ),
      floatingActionButton: Badge(
        isLabelVisible: pending.isNotEmpty,
        label: Text(pending.length.toString()),
        child: FloatingActionButton.extended(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageFriendsPage())),
          icon: const Icon(Iconsax.people_copy),
          label: const Text('Manage'),
        ),
      ),
    );
  }
}


