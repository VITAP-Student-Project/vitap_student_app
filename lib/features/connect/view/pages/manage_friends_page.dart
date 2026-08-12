import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/features/connect/viewmodel/connect_viewmodel.dart';
import 'package:vit_ap_student_app/features/connect/data/repositories/supabase_repository.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';

class ManageFriendsPage extends ConsumerStatefulWidget {
  const ManageFriendsPage({super.key});

  @override
  ConsumerState<ManageFriendsPage> createState() => _ManageFriendsPageState();
}

class _ManageFriendsPageState extends ConsumerState<ManageFriendsPage> {
  final _regNoController = TextEditingController();
  final _pinController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  @override
  void dispose() {
    _regNoController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _sendRequest() async {
    final regNo = _regNoController.text.trim().toUpperCase();
    final pin = _pinController.text.trim();

    setState(() {
      _errorMessage = null;
      _successMessage = null;
    });

    if (regNo.isEmpty || pin.isEmpty) {
      setState(() => _errorMessage = 'Please enter both Reg No and ONE TIME PIN');
      return;
    }

    setState(() => _isLoading = true);
    try {
      final repo = serviceLocator<SupabaseRepository>();
      await repo.sendFriendRequest(targetRegNo: regNo, enteredPin: pin).timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw Exception('Network timeout. Please check your connection.'),
          );
      if (mounted) {
        setState(() => _successMessage = 'Friend Request Sent!');
        _regNoController.clear();
        _pinController.clear();
        ref.read(connectViewModelProvider.notifier).refresh();
        
        // Clear success message after 3 seconds
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            setState(() => _successMessage = null);
          }
        });
      }
    } catch (e) {
      if (mounted) {
        String err = e.toString();
        if (err.contains('SocketException') || err.contains('ClientException') || err.contains('Failed host lookup')) {
          err = 'No internet connection. Please check your network and try again.';
        }
        setState(() => _errorMessage = err.replaceAll('Exception: ', ''));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _acceptRequest(String friendRegNo) async {
    setState(() => _isLoading = true);
    try {
      final repo = serviceLocator<SupabaseRepository>();
      await repo.acceptFriendRequest(senderRegNo: friendRegNo).timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw Exception('Network timeout.'),
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Friend Request Accepted!')));
        ref.read(connectViewModelProvider.notifier).refresh();
      }
    } catch (e) {
      if (mounted) {
        String err = e.toString();
        if (err.contains('SocketException') || err.contains('ClientException') || err.contains('Failed host lookup')) {
          err = 'No internet connection. Please check your network and try again.';
        }
        showSnackBar(context, err.replaceAll('Exception: ', ''), SnackBarType.error);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _cancelRequest(String friendRegNo) async {
    setState(() => _isLoading = true);
    try {
      final repo = serviceLocator<SupabaseRepository>();
      await repo.cancelFriendRequest(friendRegNo).timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw Exception('Network timeout.'),
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Friend Request Cancelled!')));
        ref.read(connectViewModelProvider.notifier).refresh();
      }
    } catch (e) {
      if (mounted) {
        String err = e.toString();
        if (err.contains('SocketException') || err.contains('ClientException') || err.contains('Failed host lookup')) {
          err = 'No internet connection. Please check your network and try again.';
        }
        showSnackBar(context, err.replaceAll('Exception: ', ''), SnackBarType.error);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _removeFriend(String friendRegNo, String name) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Friend?'),
        content: Text('Are you sure you want to stop syncing with $name?'),
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
      setState(() => _isLoading = true);
      try {
        final repo = serviceLocator<SupabaseRepository>();
        await repo.removeFriend(friendRegNo).timeout(
              const Duration(seconds: 10),
              onTimeout: () => throw Exception('Network timeout.'),
            );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Friend removed')));
          ref.read(connectViewModelProvider.notifier).refresh();
        }
      } catch (e) {
        if (mounted) {
          String err = e.toString();
          if (err.contains('SocketException') || err.contains('ClientException') || err.contains('Failed host lookup')) {
            err = 'No internet connection. Please check your network and try again.';
          }
          showSnackBar(context, err.replaceAll('Exception: ', ''), SnackBarType.error);
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final connectState = ref.watch(connectViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Friends'),
      ),
      body: connectState.when(
        data: (data) => _buildBody(context, data),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildBody(BuildContext context, Map<String, dynamic> data) {
    final pending = data['pending'] as List<dynamic>? ?? [];
    final pendingOutgoing = data['pendingOutgoing'] as List<dynamic>? ?? [];
    final friends = data['friends'] as List<dynamic>? ?? [];
    final myPin = data['myPin'] as String;

    return RefreshIndicator(
      onRefresh: () async => await ref.read(connectViewModelProvider.notifier).refresh(),
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // My PIN Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('MY ONE TIME PIN', style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold)),
                    Text(myPin, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 4, color: Theme.of(context).colorScheme.onPrimaryContainer)),
                  ],
                ),
                IconButton(
                  icon: Icon(Iconsax.refresh_copy, color: Theme.of(context).colorScheme.onPrimaryContainer),
                  onPressed: () {
                     ref.read(connectViewModelProvider.notifier).regeneratePin();
                  },
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Send Request Form
          Text('Send Request', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          TextField(
            controller: _regNoController,
            autofocus: true,
            maxLength: 12,
            textCapitalization: TextCapitalization.characters,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
            ],
            decoration: InputDecoration(
              labelText: 'Friend\'s Reg No (e.g. 21BCE1234)', 
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              prefixIcon: const Icon(Iconsax.user_copy),
              counterText: '', // hide the length counter below the text field
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _pinController,
            maxLength: 6,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              labelText: 'Friend\'s 6-Digit ONE TIME PIN', 
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              prefixIcon: const Icon(Iconsax.lock_copy),
              counterText: '', // hide length counter
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(_errorMessage!, style: TextStyle(color: Theme.of(context).colorScheme.error, fontWeight: FontWeight.bold)),
            ),
            
          if (_successMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(_successMessage!, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            ),

          SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton(
              onPressed: _isLoading ? null : _sendRequest,
              child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white) 
                  : const Text('Send Request', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          
          const SizedBox(height: 40),
          const Divider(),
          const SizedBox(height: 24),

          // Requests (Received)
          if (pending.isNotEmpty) ...[
            Text('Requests', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...pending.map((p) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(p['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(p['reg_no']),
              trailing: _isLoading ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator()) : FilledButton(
                onPressed: () => _acceptRequest(p['reg_no']),
                child: const Text('Accept'),
              ),
            )),
            const SizedBox(height: 32),
          ],

          // Pending (Sent)
          if (pendingOutgoing.isNotEmpty) ...[
            Text('Pending', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...pendingOutgoing.map((p) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(p['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(p['reg_no']),
              trailing: _isLoading ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator()) : OutlinedButton(
                onPressed: () => _cancelRequest(p['reg_no']),
                style: OutlinedButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
                child: const Text('Cancel'),
              ),
            )),
            const SizedBox(height: 32),
          ],

          // Active Friends
          if (friends.isNotEmpty) ...[
            Text('Active', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...friends.map((f) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(f['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(f['reg_no']),
              trailing: IconButton(
                icon: Icon(Iconsax.minus_cirlce_copy, color: Theme.of(context).colorScheme.error),
                onPressed: _isLoading ? null : () => _removeFriend(f['reg_no'], f['name']),
              ),
            )),
          ],
          
          if (pending.isEmpty && pendingOutgoing.isEmpty && friends.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(
                child: Text('No connections yet', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
              ),
            ),
        ],
      ),
    );
  }
}
