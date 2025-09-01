import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../strings.dart';
import 'role_picker.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(kSeenOnboarding, true);
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const RolePickerScreen()),
    );
  }

  void _next() {
    if (_index < 2) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
      );
    } else {
      _finishOnboarding();
    }
  }

  @override
  Widget build(BuildContext context) {
    final slides = [
      (Icons.local_activity, AppStrings.onboardTitle1, AppStrings.onboardSubtitle1),
      (Icons.storefront, AppStrings.onboardTitle2, AppStrings.onboardSubtitle2),
      (Icons.celebration, AppStrings.onboardTitle3, AppStrings.onboardSubtitle3),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text(
              AppStrings.appName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: slides.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (context, i) {
                  final (icon, title, subtitle) = slides[i];
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon, size: 120),
                        const SizedBox(height: 24),
                        Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 8),
                        Text(subtitle, textAlign: TextAlign.center),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
                  height: 8,
                  width: _index == i ? 24 : 8,
                  decoration: BoxDecoration(
                    color: _index == i
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _next,
                  child: Text(_index < 2 ? AppStrings.next : AppStrings.start),
                ),
              ),
            )
          ],
        ),
      ),
    );σ
  }
}
