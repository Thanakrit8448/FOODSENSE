import 'package:flutter/material.dart';
import 'package:foodsense_app/pages/bottom_nav.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('CameraPage'),
          
        ),
        bottomNavigationBar: const CustomBottomNav(currentIndex: 3),
      ),
    );
  }
}
