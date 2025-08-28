import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/common/widget/auth_field.dart';
import 'package:vit_ap_student_app/core/common/widget/loader.dart';
import 'package:vit_ap_student_app/core/models/credentials.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';
import 'package:vit_ap_student_app/features/account/view/widgets/my_semester_dropdown.dart';

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
      // Validate that semester is selected
      if (selectedSemSubID == null || selectedSemSubID!.isEmpty) {
        showSnackBar(context, "Please select a semester before saving",
            SnackBarType.error);
        return;
      }

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
      bool semesterChanged = oldCredentials?.semSubId != selectedSemSubID;

      // Debug: Log what we're saving
      debugPrint(
          "Saving credentials with semSubId: '${newCredentials.semSubId}'");

      await notifier.updateSavedCredentials(newCredentials: newCredentials);
      if (!mounted) return;
      showSnackBar(
          context, "Credentials updated successfully", SnackBarType.success);
      Navigator.pop(context, semesterChanged);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manage Credentials',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      body: FutureBuilder<Credentials?>(
        future: _credentialsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Loader();
          }
          final credentials = snapshot.data;
          debugPrint("Current semSubId: '${credentials?.semSubId ?? "null"}'");
          _usernameController = TextEditingController(
              text: credentials?.registrationNumber ?? '');
          _passwordController =
              TextEditingController(text: credentials?.password ?? '');

          // If semSubId is empty or null, don't set it as selectedSemSubID
          // This forces the user to actively select a semester
          final currentSemSubId = credentials?.semSubId;
          selectedSemSubID =
              (currentSemSubId != null && currentSemSubId.isNotEmpty)
                  ? currentSemSubId
                  : null;

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
                  if (credentials != null) ...[
                    const SizedBox(height: 24),
                    MySemesterDropDownWidget(
                      credentials: credentials,
                      onSelected: (value) {
                        selectedSemSubID = value;
                      },
                      initialValue: selectedSemSubID,
                    ),
                    // Show warning if no semester is selected
                    if (selectedSemSubID == null ||
                        selectedSemSubID!.isEmpty) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.errorContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              color: Theme.of(context).colorScheme.error,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Please select a semester to ensure the app works correctly",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
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
