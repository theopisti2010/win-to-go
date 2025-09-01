import 'package:flutter/material.dart';
import '../strings.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.tabMy)),
      body: const Center(child: Text('My tickets / participations')),
    );
  }
}
