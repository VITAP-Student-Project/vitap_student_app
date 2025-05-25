import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../utils/api/wifi/university_wifi.dart';
import '../../../utils/data/wifi_preferences.dart';
import '../../../widgets/custom/custom_text_field.dart';

class UniversityWifiTab extends StatefulWidget {
  const UniversityWifiTab({Key? key}) : super(key: key);

  @override
  State<UniversityWifiTab> createState() => _UniversityWifiTabState();
}

class _UniversityWifiTabState extends State<UniversityWifiTab> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberPassword = false;
  bool isLoading = false;
  final FortigatePortalAuth _portalAuth = FortigatePortalAuth();

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  void _loadSavedCredentials() async {
    final credentials = await WifiPreferencesService.getCredentials();
    setState(() {
      usernameController.text = credentials['username'];
      passwordController.text = credentials['password'];
      rememberPassword = credentials['rememberMe'];
    });
  }

  Future<void> handleLogin() async {
    final username = usernameController.text;
    final password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      _showSnackBar("Please fill in both fields", Colors.yellow.shade400);
      return;
    }

    setState(() => isLoading = true);

    try {
      // Get portal parameters first
      final params = await _portalAuth.getPortalParameters();

      if (params['magic'] == null || params['4Tredir'] == null) {
        _showSnackBar("Failed to connect to WiFi portal", Colors.red);
        return;
      }

      // Attempt login
      final result = await _portalAuth.login(
        username: username,
        password: password,
        magic: params['magic']!,
        fourTredir: params['4Tredir']!,
      );

      if (result['success']) {
        if (rememberPassword) {
          await WifiPreferencesService.saveCredentials(
            username: username,
            password: password,
            rememberMe: true,
          );
        }
        _showSnackBar(
            "Successfully connected to University WiFi", Colors.green);
      } else {
        _showSnackBar(result['error'] ?? "Login failed", Colors.red);
      }
    } catch (e) {
      log('Login error: $e');
      _showSnackBar("Connection error occurred", Colors.red);
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> handleLogout() async {
    if (rememberPassword) {
      await WifiPreferencesService.clearCredentials();
    }
    setState(() {
      usernameController.clear();
      passwordController.clear();
      rememberPassword = false;
    });
    _showSnackBar("Logged out successfully", Colors.blue);
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        backgroundColor: color,
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: usernameController,
            label: "University Wi-Fi Username",
          ),
          CustomTextField(
            controller: passwordController,
            label: "University Wi-Fi Password",
            obscureText: true,
          ),
          Row(
            children: [
              Checkbox(
                value: rememberPassword,
                onChanged: isLoading
                    ? null
                    : (value) {
                        setState(() {
                          rememberPassword = value!;
                          if (!value) {
                            WifiPreferencesService.clearCredentials();
                          }
                        });
                      },
              ),
              const Text("Remember Me"),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: isLoading ? null : handleLogin,
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text("Login"),
              ),
              ElevatedButton(
                onPressed: isLoading ? null : handleLogout,
                child: const Text("Logout"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
