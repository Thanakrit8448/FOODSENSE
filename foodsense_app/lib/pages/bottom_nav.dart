import 'package:flutter/material.dart';
import 'package:foodsense_app/pages/home_page.dart';
import 'package:foodsense_app/pages/map_page.dart';
import 'package:foodsense_app/pages/Database_page.dart';
import 'package:foodsense_app/pages/camera_page.dart';
import 'package:foodsense_app/pages/history_page.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNav({super.key, required this.currentIndex});

  void _navigateToPage(BuildContext context, int index) {
    Widget nextPage;

    switch (index) {
      case 0:
        nextPage = const HomePage();
        break;
      case 1:
        nextPage = const MapPage();
        break;
      case 2:
        nextPage = const DatabasePage();
        break;
      case 3:
        nextPage = const CameraPage();
        break;
      case 4:
        nextPage = const HistoryPage();
        break;
      default:
        return;
    }

    if (index != currentIndex) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => nextPage),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: currentIndex,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          type: BottomNavigationBarType.fixed,
          onTap: (index) => _navigateToPage(context, index),
          items: [
            _navItem('home', 28),
            _navItem('map', 32),
            _navItem('add', 28),
            _navItem('camera', 28),
            _navItem('book', 28),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _navItem(String iconName, double width) {

    return BottomNavigationBarItem(
      icon: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Image.asset(
            'assets/icons/${iconName}_gray.png',
            width: width,
          ),
        ),
      ),
      activeIcon: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Image.asset(
            'assets/icons/${iconName}_purple.png',
            width: width,
          ),
        ),
      ),
      label: '',
    );
  }

}
