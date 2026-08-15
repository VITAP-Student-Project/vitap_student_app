import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/common/widget/auth_field.dart';
import 'package:vit_ap_student_app/core/common/widget/faq_link.dart';
import 'package:vit_ap_student_app/core/common/widget/loader.dart';
import 'package:vit_ap_student_app/core/models/credentials.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';
import 'package:vit_ap_student_app/features/account/model/faq_content.dart';

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

  Future<Credentials?>? _credentialsFuture;

  @override
  void initState() {
    super.initState();
    final notifier = ref.read(currentUserProvider.notifier);
    _credentialsFuture = notifier.getSavedCredentials();
  }

  Future<void> _saveCredentials() async {
    if (_formKey.currentState?.validate() ?? false) {
      final notifier = ref.read(currentUserProvider.notifier);
      final Credentials? oldCredentials = await notifier.getSavedCredentials();

      final Credentials newCredentials =
          oldCredentials?.copyWith(
            registrationNumber: _usernameController.text.trim(),
            password: _passwordController.text.trim(),
          ) ??
          Credentials(
            registrationNumber: _usernameController.text.trim(),
            password: _passwordController.text.trim(),
            semSubId: oldCredentials?.semSubId ?? '',
          );

      await notifier.updateSavedCredentials(newCredentials: newCredentials);
      if (!mounted) return;
      showSnackBar(
        context,
        'Credentials updated successfully',
        SnackBarType.success,
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manage Credentials',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      body: FutureBuilder<Credentials?>(
        future: _credentialsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Loader();
          }
          final credentials = snapshot.data;
          _usernameController = TextEditingController(
            text: credentials?.registrationNumber ?? '',
          );
          _passwordController = TextEditingController(
            text: credentials?.password ?? '',
          );

          // Shares AuthField with the login page, so it inherits the filled
          // treatment; the button and the single AutofillGroup are matched here
          // so the two credential screens don't drift apart.
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Form(
              key: _formKey,
              child: AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AuthField(
                      controller: _usernameController,
                      hintText: 'Username',
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.characters,
                    ),
                    const SizedBox(height: 14),
                    AuthField(
                      hintText: 'Password',
                      controller: _passwordController,
                      isObscureText: true,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _saveCredentials(),
                    ),
                    const SizedBox(height: 20),
                    // This is the screen people are sent to when they ask how to
                    // change semester, so the answer belongs here rather than
                    // only in a reference page they never open.
                    const FaqLink(
                      topic: FaqTopic.changeSemester,
                      text:
                          'Changing your semester or password here takes effect '
                          'from the next sync. Refresh a screen if it still '
                          'shows the old data.',
                      linkText: 'How semester changes work',
                    ),
                    const SizedBox(height: 20),

                    FilledButton(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(56),
                        shape: const StadiumBorder(),
                        textStyle: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      onPressed: _saveCredentials,
                      child: const Text('Save'),
                    ),
                  ],
                ),
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
