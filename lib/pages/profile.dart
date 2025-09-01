import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../strings.dart';

class ProfilePage extends StatelessWidget {
  Future<void> _resetPrefs(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Τα δεδομένα καθαρίστηκαν. Κάνε refresh (⌘R).')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('${AppStrings.tabProfile} (dev)')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text('Guest User'),
            subtitle: Text('guest@wintogo.app'),
          ),
          const Divider(),
          const ListTile(leading: Icon(Icons.lock_outline), title: Text('Απόρρητο & Όροι')),
          const ListTile(leading: Icon(Icons.notifications_outlined), title: Text('Ειδοποιήσεις')),
          const ListTile(leading: Icon(Icons.help_outline), title: Text('Βοήθεια')),
          const ListTile(leading: Icon(Icons.logout), title: Text('Αποσύνδεση')),
          const SizedBox(height: 12),
          ListTile(
            leading: const Icon(Icons.restore),
            title: const Text('Reset app data (dev)'),
            subtitle: const Text('Καθαρίζει αποθηκευμένες προτιμήσεις για Onboarding/Role'),
            onTap: () => _resetPrefs(context),
          ),
        ],
      ),
    );
  }
}
