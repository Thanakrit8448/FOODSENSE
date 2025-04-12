import 'package:flutter/material.dart';
import 'package:foodsense_app/pages/bottom_nav.dart';


class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('MapPage'),
        ),
        bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
      ),
    );
  }
}
