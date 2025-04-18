import 'package:flutter/material.dart';
import 'package:foodsense_app/pages/map_page.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar (fixed)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios_new),
                  ),
                  const Text(
                    'Detail',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      child: Image.asset(
                        isFavorite
                            ? 'assets/icons/heart_red.png'
                            : 'assets/icons/heart_black.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/icons/Pad_Thai.jpg'),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Title
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Pad thai',
                        style: TextStyle(fontSize: 22, fontFamily: 'Sora'),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'One dish meal',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Divider
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 48),
                      child: Divider(),
                    ),

                    // Description
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Description',
                        style: TextStyle(
                          fontFamily: 'Sora',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        'Pad thai is a stir-fried rice noodle dish commonly served as a street food in Thailand as part of the country\'s cuisine. Thailand\'s national dish, it is typically made with rice noodles, shrimp, peanuts, scrambled egg, sugar and bean sprouts. The ingredients are fried in a wok.',
                        style: TextStyle(color: Colors.grey, height: 1.5),
                      ),
                    ),

                    // Calories
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Calories',
                        style: TextStyle(
                          fontFamily: 'Sora',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: Text(
                        'พลังงานทั้งหมด 303 กิโลแคลอรี่',
                        style: TextStyle(
                          color: Color(0xFF9747FF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        '1 plate of Pad Thai has total calories 303 kilocalories, protein 11 g., carbohydrate 31 g. and Fat 15 g. vitamins and minerals please see more information on nutrition facts sheet below.',
                        style: TextStyle(color: Colors.grey, height: 1.5),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Button
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
          bottom: 30,
          top: 25,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF9747FF),
            minimumSize: const Size.fromHeight(60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MapPage()),
            );
          },
          child: const Text(
            'OPEN LOCATION',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
