import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../strings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _resetPrefs(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Έγινε reset. Κάνε refresh (⌘R).')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          snap: true,
          title: const Text(AppStrings.appName),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_outlined),
              tooltip: AppStrings.notifications,
            ),
            // 🔧 DEV: Reset app data
            IconButton(
              onPressed: () => _resetPrefs(context),
              icon: const Icon(Icons.restore),
              tooltip: 'Reset app data (dev)',
            ),
          ],
        ),

        // Φίλτρα (placeholder)
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              children: const [
                _FilterChip(label: 'Όλα', selected: true),
                _FilterChip(label: 'Εστίαση'),
                _FilterChip(label: 'Ρουχισμός'),
                _FilterChip(label: 'Υποδήματα'),
                _FilterChip(label: 'Σήμερα'),
                _FilterChip(label: 'Κοντά μου'),
              ],
            ),
          ),
        ),

        // Λίστα καρτών (placeholder δεδομένα)
        SliverList.list(
          children: const [
            _ContestCard(
              status: 'Closing soon',
              title: '2 ποτά δωρεάν',
              subtitle: 'Bar Popi · Κέντρο',
              timeLeft: '1h 15m',
            ),
            _ContestCard(
              status: 'Open',
              title: 'Έκπτωση 50% σε burger',
              subtitle: 'Burger Town · Νότια',
              timeLeft: '3h 05m',
            ),
          ],
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  const _FilterChip({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        selected: selected,
        label: Text(label),
        selectedColor: cs.surfaceContainerHighest,
        onSelected: (_) {},
      ),
    );
  }
}

class _ContestCard extends StatelessWidget {
  final String status;
  final String title;
  final String subtitle;
  final String timeLeft;
  const _ContestCard({
    required this.status,
    required this.title,
    required this.subtitle,
    required this.timeLeft,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // εικόνα/gradient
            Container(
              height: 220,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [cs.primary.withOpacity(0.15), cs.secondary.withOpacity(0.15)],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 12,
                    top: 12,
                    child: Chip(
                      label: Text(status),
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                  Positioned(
                    right: 12,
                    bottom: 12,
                    child: Chip(
                      avatar: const Icon(Icons.hourglass_bottom, size: 16),
                      label: Text(timeLeft),
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                  const Center(child: Icon(Icons.local_offer, size: 64)),
                ],
              ),
            ),
            // τίτλοι
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.storefront_outlined, size: 16),
                      const SizedBox(width: 6),
                      Text(subtitle),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
