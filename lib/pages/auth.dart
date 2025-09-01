import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../strings.dart';
import '../root_scaffold.dart';

class AuthScreen extends StatelessWidget {
  final UserRole role;
  const AuthScreen({super.key, required this.role});

  Future<void> _continueAsGuest(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(kSeenOnboarding, true);
    if (!context.mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const RootScaffold()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final roleLabel = role == UserRole.pro ? AppStrings.rolePro : AppStrings.roleConsumer;

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.authTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ρόλος: $roleLabel', style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {}, // backend αργότερα
                icon: const Icon(Icons.mail_outline),
                label: const Text(AppStrings.loginEmail),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {}, // Google αργότερα
                icon: const Icon(Icons.g_mobiledata, size: 28),
                label: const Text(AppStrings.loginGoogle),
              ),
            ),
            const Spacer(),
            Center(
              child: TextButton(
                onPressed: () => _continueAsGuest(context),
                child: const Text(AppStrings.continueGuest),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
