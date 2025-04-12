import 'package:flutter/material.dart';
import 'package:foodsense_app/pages/bottom_nav.dart';


class DatabasePage extends StatelessWidget {
  const DatabasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('DatabasePage'),
        ),
        bottomNavigationBar: const CustomBottomNav(currentIndex: 2),
      ),
    );
  }
}
