import 'package:flutter/material.dart';
import 'root_scaffold.dart';
import 'strings.dart';

void main() {
  runAppWin To Go 🚀(const ());
}

class WinToGoApp extends StatelessWidget {
  const WinToGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF4F46E5); // προσωρινό brand color
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark),
      ),
      home: const RootScaffold(), // 👈 ξεκινάει από το shell με τα tabs
    );
  }
}
