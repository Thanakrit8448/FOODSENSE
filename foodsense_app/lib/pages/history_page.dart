import 'package:flutter/material.dart';
import 'package:foodsense_app/pages/bottom_nav.dart';


class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('HistoryPage'),
        ),
        bottomNavigationBar: const CustomBottomNav(currentIndex: 4),
      ),
    );
  }
}
