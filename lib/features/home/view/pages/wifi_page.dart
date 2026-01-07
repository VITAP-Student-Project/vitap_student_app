import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/common/widget/loader.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/features/account/view/pages/faq_page.dart';
import 'package:vit_ap_student_app/features/home/viewmodel/wifi_viewmodel.dart';

class WifiPage extends ConsumerStatefulWidget {
  const WifiPage({super.key});

  @override
  WifiPageState createState() => WifiPageState();
}

class WifiPageState extends ConsumerState<WifiPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  void _loadSavedCredentials() async {
    final credentials = await ref
        .read(currentUserNotifierProvider.notifier)
        .getSavedCredentials();
    if (mounted) {
      setState(() {
        usernameController.text = credentials?.wifiUsername ?? "";
        passwordController.text = credentials?.wifiPassword ?? "";
      });
    }
  }

  String? _validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required';
    }
    if (value.trim().length < 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 4) {
      return 'Password must be at least 4 characters';
    }
    return null;
  }

  Future<void> handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final username = usernameController.text.trim();
    final password = passwordController.text;

    final credentials = await ref
        .read(currentUserNotifierProvider.notifier)
        .getSavedCredentials();

    if (credentials != null) {
      await ref
          .read(currentUserNotifierProvider.notifier)
          .updateSavedCredentials(
            newCredentials: credentials.copyWith(
              wifiUsername: username,
              wifiPassword: password,
            ),
          );
    }

    await ref.read(wifiViewModelProvider.notifier).wifiLogin();
  }

  Future<void> handleLogout() async {
    await ref.read(wifiViewModelProvider.notifier).wifiLogout();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      wifiViewModelProvider.select((val) => val?.isLoading == true),
    );

    final wifiResponse = ref.watch(
      wifiViewModelProvider.select((val) => val?.asData?.value),
    );

    final wifiState = ref.watch(wifiViewModelProvider);
    String? errorMessage;
    wifiState?.whenOrNull(
      error: (error, st) {
        errorMessage = error.toString();
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
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
                          "University WiFi Login",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Connect to VIT-AP University Wi-Fi network using your credentials.",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Username field with validation
              TextFormField(
                controller: usernameController,
                validator: _validateUsername,
                decoration: InputDecoration(
                  hintText: "Wi-Fi Username",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceContainer,
                ),
                textInputAction: TextInputAction.next,
                enabled: !isLoading,
              ),
              const SizedBox(height: 12),

              // Password field with validation
              TextFormField(
                controller: passwordController,
                validator: _validatePassword,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: "Wi-Fi Password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceContainer,
                ),
                textInputAction: TextInputAction.done,
                enabled: !isLoading,
                onFieldSubmitted: (_) => handleLogin(),
              ),
              const SizedBox(height: 24),

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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: isLoading ? null : handleLogin,
                      child: isLoading
                          ? const SizedBox(
                              height: 20, width: 20, child: Loader())
                          : const Text("Login"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.surfaceContainer,
                        foregroundColor:
                            Theme.of(context).colorScheme.onSurface,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: isLoading ? null : handleLogout,
                      child: const Text("Logout"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Error message from Failure
              if (errorMessage != null && wifiResponse == null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.red.shade900.withOpacity(0.3)
                        : Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.red.shade700
                          : Colors.red.shade300,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.red.shade300
                            : Colors.red.shade700,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          errorMessage!,
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.red.shade300
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

              // Connection status indicator
              if (wifiResponse != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: wifiResponse.success
                        ? (Theme.of(context).brightness == Brightness.dark
                            ? Colors.green.shade900.withOpacity(0.3)
                            : Colors.green.shade50)
                        : (Theme.of(context).brightness == Brightness.dark
                            ? Colors.red.shade900.withOpacity(0.3)
                            : Colors.red.shade50),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: wifiResponse.success
                          ? (Theme.of(context).brightness == Brightness.dark
                              ? Colors.green.shade700
                              : Colors.green.shade300)
                          : (Theme.of(context).brightness == Brightness.dark
                              ? Colors.red.shade700
                              : Colors.red.shade300),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        wifiResponse.success ? Icons.wifi : Icons.wifi_off,
                        color: wifiResponse.success
                            ? (Theme.of(context).brightness == Brightness.dark
                                ? Colors.green.shade300
                                : Colors.green.shade700)
                            : (Theme.of(context).brightness == Brightness.dark
                                ? Colors.red.shade300
                                : Colors.red.shade700),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              wifiResponse.success
                                  ? "Connected to University Wi-Fi"
                                  : "Connection Failed",
                              style: TextStyle(
                                color: wifiResponse.success
                                    ? (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.green.shade300
                                        : Colors.green.shade700)
                                    : (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.red.shade300
                                        : Colors.red.shade700),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (wifiResponse.message.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                wifiResponse.message,
                                style: TextStyle(
                                  color: wifiResponse.success
                                      ? (Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.green.shade300
                                          : Colors.green.shade700)
                                      : (Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.red.shade300
                                          : Colors.red.shade700),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Bypass login limit button
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FAQPage(expandedIndex: 6),
                    ),
                  );
                },
                child: Text(
                  "How to bypass university Wi-Fi login limit?",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: Theme.of(context).colorScheme.primary,
                      ),
                  textAlign: TextAlign.center,
                ),
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
