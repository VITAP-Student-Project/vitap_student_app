import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../utils/api/wifi/hostel_wifi.dart';
import '../../../utils/data/wifi_preferences.dart';
import '../../../widgets/custom/custom_text_field.dart';

class HostelWifiTab extends StatefulWidget {
  const HostelWifiTab({Key? key}) : super(key: key);

  @override
  State<HostelWifiTab> createState() => _HostelWifiTabState();
}

class _HostelWifiTabState extends State<HostelWifiTab> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberPassword = false;

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

  void handleLogin() async {
    final username = usernameController.text;
    final password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      _showSnackBar("Please fill in both fields", Colors.yellow.shade400);
      return;
    }

    if (rememberPassword) {
      await WifiPreferencesService.saveCredentials(
          username: username, password: password, rememberMe: true);
    }

    final response = await HostelWifiService.login(username, password);
    log(response.message);
    _showSnackBar(response.message, response.color);
  }

  void handleLogout() async {
    final username = usernameController.text;
    final password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      _showSnackBar("Please fill in both fields", Colors.yellow.shade400);
      return;
    }

    if (rememberPassword) {
      await WifiPreferencesService.clearCredentials();
    }

    final response = await HostelWifiService.logout(username, password);
    log(response.message);
    _showSnackBar(response.message, response.color);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hostel Wi-Fi Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: usernameController,
              label: "Wi-Fi Username",
            ),
            CustomTextField(
              controller: passwordController,
              label: "Wi-Fi Password",
              obscureText: true,
            ),
            Row(
              children: [
                Checkbox(
                  value: rememberPassword,
                  onChanged: (value) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: handleLogin,
                  child: const Text("Login"),
                ),
                ElevatedButton(
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
