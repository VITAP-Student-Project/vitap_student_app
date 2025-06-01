import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/common/widget/auth_field.dart';
import 'package:vit_ap_student_app/core/models/credentials.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';
import 'package:vit_ap_student_app/features/auth/view/widgets/my_semester_dropdown.dart';

class ManageCredentialsPage extends ConsumerStatefulWidget {
  const ManageCredentialsPage({super.key});

  @override
  ConsumerState<ManageCredentialsPage> createState() =>
      _ManageCredentialsPageState();
}

class _ManageCredentialsPageState extends ConsumerState<ManageCredentialsPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  String? selectedSemSubID;

  Future<Credentials?>? _credentialsFuture;

  @override
  void initState() {
    super.initState();
    final notifier = ref.read(currentUserNotifierProvider.notifier);
    _credentialsFuture = notifier.getSavedCredentials();
  }

  Future<void> _saveCredentials() async {
    if (_formKey.currentState?.validate() ?? false) {
      final notifier = ref.read(currentUserNotifierProvider.notifier);
      final Credentials? oldCredentials = await notifier.getSavedCredentials();
      final Credentials newCredentials = oldCredentials?.copyWith(
            registrationNumber: _usernameController.text.trim(),
            password: _passwordController.text.trim(),
            semSubId: selectedSemSubID!,
          ) ??
          Credentials(
            registrationNumber: _usernameController.text.trim(),
            password: _passwordController.text.trim(),
            semSubId: selectedSemSubID!,
          );
      await notifier.updateSavedCredentials(newCredentials: newCredentials);
      if (!mounted) return;
      showSnackBar(
          context, "Credentials updated successfully", SnackBarType.success);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Credentials')),
      body: FutureBuilder<Credentials?>(
        future: _credentialsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          final credentials = snapshot.data;
          _usernameController = TextEditingController(
              text: credentials?.registrationNumber ?? '');
          _passwordController =
              TextEditingController(text: credentials?.password ?? '');
          selectedSemSubID = credentials?.semSubId;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                  ),
                  AuthField(
                    controller: _usernameController,
                    hintText: 'Username',
                  ),
                  const SizedBox(height: 12),
                  AuthField(
                    hintText: 'Password',
                    controller: _passwordController,
                    isObscureText: true,
                  ),
                  const SizedBox(height: 24),
                  MySemesterDropDownWidget(
                    onSelected: (value) {
                      selectedSemSubID = value;
                    },
                    initialValue: selectedSemSubID,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.secondaryContainer,
                      minimumSize:
                          Size(MediaQuery.sizeOf(context).width - 100, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                    ),
                    onPressed: _saveCredentials,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
