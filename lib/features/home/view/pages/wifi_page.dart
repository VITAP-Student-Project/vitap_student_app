import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/common/widget/auth_field.dart';
import 'package:vit_ap_student_app/core/common/widget/loader.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';
import 'package:vit_ap_student_app/features/home/model/wifi_response.dart';
import 'package:vit_ap_student_app/features/home/viewmodel/wifi_viewmodel.dart';

class WifiPage extends ConsumerStatefulWidget {
  const WifiPage({super.key});

  @override
  WifiPageState createState() => WifiPageState();
}

class WifiPageState extends ConsumerState<WifiPage>
    with SingleTickerProviderStateMixin {
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

    // Auto-login if credentials are available
    if (credentials?.hostelWifiUsername?.isNotEmpty == true &&
        credentials?.hostelWifiPassword?.isNotEmpty == true) {
      handleLogin();
    }
  }

  Future<void> handleLogin() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      showSnackBar(
        context,
        "Please enter both username and password",
        SnackBarType.error,
      );
      return;
    }

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

    // Use the unified login method that tries hostel first, then university
    await ref.read(wifiViewModelProvider.notifier).unifiedWifiLogin();
  }

  Future<void> handleLogout() async {
    // Use the unified logout method that tries both networks
    await ref.read(wifiViewModelProvider.notifier).unifiedWifiLogout();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      wifiViewModelProvider.select((val) => val?.isLoading == true),
    );

    final wifiResponse = ref.watch(
      wifiViewModelProvider.select((val) => val?.asData?.value),
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wi-Fi',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Loader()
            : Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Info container
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Theme.of(context).colorScheme.primary,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "WiFi Login",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Automatically detects and connects to the available campus WiFi network (Hostel or University). Assuming that you use the same credentials for both networks.",
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Username field
                    Center(
                      child: AuthField(
                        controller: usernameController,
                        hintText: "Wi-Fi Username",
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Password field
                    Center(
                      child: AuthField(
                        controller: passwordController,
                        hintText: "Wi-Fi Password",
                        isObscureText: true,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Status indicator
                    if (wifiResponse != null) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: wifiResponse.success
                              ? Colors.green.shade50
                              : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: wifiResponse.success
                                ? Colors.green.shade300
                                : Colors.red.shade300,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              wifiResponse.success
                                  ? Icons.wifi
                                  : Icons.wifi_off,
                              color: wifiResponse.success
                                  ? Colors.green.shade700
                                  : Colors.red.shade700,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                wifiResponse.success
                                    ? "Connected to ${wifiResponse.wifiType == WifiType.hostel ? 'Hostel' : 'University'} Wi-Fi"
                                    : "Not connected to campus Wi-Fi",
                                style: TextStyle(
                                  color: wifiResponse.success
                                      ? Colors.green.shade700
                                      : Colors.red.shade700,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: wifiResponse?.success == true
                                  ? Colors.green.shade600
                                  : Theme.of(context).colorScheme.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            onPressed: handleLogin,
                            child: Text("Login"),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                              foregroundColor:
                                  Theme.of(context).colorScheme.onSurface,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            onPressed: handleLogout,
                            child: Text("Logout"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Help text
                    Text(
                      "💡 Tip: The app will automatically try hostel Wi-Fi first, then university Wi-Fi if the first attempt fails.",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            fontStyle: FontStyle.italic,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
