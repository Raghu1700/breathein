import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            subtitle: Text(auth.phoneNumber ?? 'No phone number'),
            onTap: () {
              // TODO: Implement profile editing
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            trailing: Switch(
              value: true, // TODO: Implement notification settings
              onChanged: (value) {
                // TODO: Implement notification toggle
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy'),
            onTap: () {
              // TODO: Implement privacy settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help & Support'),
            onTap: () {
              // TODO: Implement help & support
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () async {
              await auth.signOut();
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
