import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../utils/provider/wifi/university_wifi_provider.dart';

class UniversityWifiTab extends ConsumerWidget {
  UniversityWifiTab({Key? key}) : super(key: key);

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final storage = const FlutterSecureStorage();
  bool _rememberMe = false;

  Future<void> loadCredentials() async {
    _usernameController.text = await storage.read(key: 'username') ?? '';
    _passwordController.text = await storage.read(key: 'password') ?? '';
    _rememberMe = _usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  Future<void> saveCredentials(
      bool remember, String username, String password) async {
    if (remember) {
      await storage.write(key: 'username', value: username);
      await storage.write(key: 'password', value: password);
    } else {
      await storage.deleteAll();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Username'),
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          Row(
            children: [
              Checkbox(
                value: _rememberMe,
                onChanged: (value) {
                  _rememberMe = value!;
                },
              ),
              const Text('Remember Me')
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final username = _usernameController.text;
              final password = _passwordController.text;

              final loginFuture = ref.read(universityWifiLoginProvider({
                'username': username,
                'password': password,
              }).future);

              loginFuture.then((isSuccess) {
                if (isSuccess) {
                  saveCredentials(_rememberMe, username, password);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Login successful!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Login failed')),
                  );
                }
              }).catchError((error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $error')),
                );
              });
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
