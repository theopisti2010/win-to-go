import 'package:flutter/material.dart';
import '../strings.dart';

class CreatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.tabCreate)),
      body: const Center(child: Text('Create page (pro only placeholder)')),
    );
  }
}
