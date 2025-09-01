import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../strings.dart';
import '../services/session.dart';
import '../models/role.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserRole _role = UserRole.consumer;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final r = await SessionService().getRole();
    if (mounted) setState(() => _role = r);
  }

  Future<void> _setRole(UserRole r) async {
    await SessionService().setRole(r);
    if (!mounted) return;
    setState(() => _role = r);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Ρόλος: ${r.displayName}. Κάνε Refresh.')),
    );
  }

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
    final isPro = _role == UserRole.pro;

    return Scaffold(
      appBar: AppBar(title: const Text('${AppStrings.tabProfile} (dev)')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(isPro ? 'Επαγγελματίας' : 'Καταναλωτής'),
            subtitle: Text(isPro ? 'Προβολή καταστήματος & διαγωνισμοί' : 'Συμμετοχές, κουπόνια, σχόλια'),
            trailing: Chip(label: Text(_role.displayName)),
          ),
          const Divider(),

          if (isPro) ...[
            const ListTile(
              leading: Icon(Icons.storefront_outlined),
              title: Text('Επαγγελματικό προφίλ'),
              subtitle: Text('Στοιχεία τιμολόγησης, φωτογραφίες καταστήματος (max 3), διαγωνισμοί'),
            ),
            const ListTile(
              leading: Icon(Icons.receipt_long),
              title: Text('Στοιχεία τιμολόγησης'),
              subtitle: Text('Επωνυμία, ΑΦΜ/ΔΟΥ, διεύθυνση, email τιμολόγησης'),
            ),
            const ListTile(
              leading: Icon(Icons.add_box_outlined),
              title: Text('Διαγωνισμοί'),
              subtitle: Text('Δημιουργία/διαχείριση, φωτογραφίες (max 3), ημερομηνία κλήρωσης'),
            ),
          ] else ...[
            const ListTile(
              leading: Icon(Icons.shopping_bag_outlined),
              title: Text('Κουπόνια έξτρα συμμετοχής'),
              subtitle: Text('Αγορά κουπονιών για περισσότερες συμμετοχές'),
            ),
            const ListTile(
              leading: Icon(Icons.reviews_outlined),
              title: Text('Σχόλια'),
              subtitle: Text('Άφησε σχόλια σε διαγωνισμούς/καταστήματα'),
            ),
            const ListTile(
              leading: Icon(Icons.emoji_events_outlined),
              title: Text('Νικητής; Ανέβασε φωτογραφίες δώρου'),
              subtitle: Text('Μέχρι 3 φωτογραφίες ως απόδειξη παραλαβής'),
            ),
          ],

          const Divider(),
          const SizedBox(height: 8),
          const Text('🔧 Developer actions', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton.icon(
                onPressed: () => _setRole(UserRole.consumer),
                icon: const Icon(Icons.person_outline),
                label: const Text('Γίνε Καταναλωτής'),
              ),
              ElevatedButton.icon(
                onPressed: () => _setRole(UserRole.pro),
                icon: const Icon(Icons.store_mall_directory_outlined),
                label: const Text('Γίνε Επαγγελματίας'),
              ),
              ElevatedButton.icon(
                onPressed: () => _resetPrefs(context),
                icon: const Icon(Icons.restore),
                label: const Text('Reset app data (dev)'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
