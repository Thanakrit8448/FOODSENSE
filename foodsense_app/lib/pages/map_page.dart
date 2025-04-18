import 'package:flutter/material.dart';
import 'package:foodsense_app/pages/home_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:foodsense_app/pages/bottom_nav.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;

  final LatLng _muMahidolLatLng = const LatLng(
    13.794389,
    100.322130,
  ); // พิกัด ม.มหิดล

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _muMahidolLatLng,
              zoom: 17,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('mahidol'),
                position: _muMahidolLatLng,
                infoWindow: const InfoWindow(
                  title: 'มหาวิทยาลัยมหิดล',
                  snippet: 'Salaya Campus',
                ),
              ),
            },
          ),
          // ปุ่ม Back และ Settings
          Positioned(
            top: 40,
            left: 20,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF9747FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false,
                  );
                },
              ),
            ),
          ),

          Positioned(
            top: 40,
            right: 20,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF9747FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: IconButton(
                icon: const Icon(Icons.my_location, color: Colors.white),
                onPressed: () {
                  mapController.animateCamera(
                    CameraUpdate.newLatLng(_muMahidolLatLng),
                  );
                },
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Center(
                    child: Text(
                      'Distance 1 kilometer',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sora',
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'มหาวิทยาลัยมหิดล',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Sora',
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Color(0xFF9747FF)),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '999 ถ. พุทธมณฑลสาย 4 ตำบล ศาลายา\nอำเภอพุทธมณฑล นครปฐม 73170',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.phone, color: Color(0xFF9747FF)),
                      SizedBox(width: 8),
                      Text('028496000'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: Color(0xFF9747FF)),
                      SizedBox(width: 8),
                      Text('วันจันทร์ • 9:00–17:00'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
