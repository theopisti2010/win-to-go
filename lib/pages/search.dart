import 'package:flutter/material.dart';
import '../strings.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.tabSearch)),
      body: const Center(child: Text('Search page')),
    );
  }
}
