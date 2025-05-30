import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/common/widget/auth_field.dart';
import 'package:vit_ap_student_app/core/common/widget/loader.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';
import 'package:vit_ap_student_app/features/home/viewmodel/wifi_viewmodel.dart';

class HostelWifiTab extends ConsumerStatefulWidget {
  const HostelWifiTab({super.key});

  @override
  ConsumerState<HostelWifiTab> createState() => _HostelWifiTabState();
}

class _HostelWifiTabState extends ConsumerState<HostelWifiTab> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  void _loadSavedCredentials() async {
    final credentials = await ref
        .read(currentUserNotifierProvider.notifier)
        .getSavedCredentials();
    setState(() {
      usernameController.text = credentials?.hostelWifiUsername ?? "";
      passwordController.text = credentials?.hostelWifiPassword ?? "";
    });
  }

  Future<void> handleLogin() async {
    final username = usernameController.text;
    final password = passwordController.text;

    // Validate form fields
    if (!_formKey.currentState!.validate()) return;

    final credentials = await ref
        .read(currentUserNotifierProvider.notifier)
        .getSavedCredentials();

    if (credentials != null) {
      await ref
          .read(currentUserNotifierProvider.notifier)
          .updateSavedCredentials(
            newCredentials: credentials.copyWith(
              hostelWifiUsername: username,
              hostelWifiPassword: password,
            ),
          );
    }
    await ref.read(wifiViewModelProvider.notifier).hostelWifiLogin();
  }

  Future<void> handleLogout() async {
    await ref.read(wifiViewModelProvider.notifier).hostelWifiLogout();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      wifiViewModelProvider.select((val) => val?.isLoading == true),
    );
    ref.listen(
      wifiViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            showSnackBar(
              context,
              data.message,
              data.snackBarType,
            );
          },
          loading: () {},
          error: (error, st) {
            showSnackBar(
              context,
              error.toString(),
              SnackBarType.error,
            );
          },
        );
      },
    );
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: isLoading
          ? Loader()
          : Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AuthField(
                    controller: usernameController,
                    hintText: "Wi-Fi Username",
                  ),
                  AuthField(
                    controller: passwordController,
                    hintText: "Wi-Fi Password",
                    isObscureText: true,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                        ),
                        onPressed: handleLogin,
                        child: const Text("Login"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                        ),
                        onPressed: handleLogout,
                        child: const Text("Logout"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
