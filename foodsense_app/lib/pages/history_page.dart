import 'package:flutter/material.dart';
import 'package:foodsense_app/pages/bottom_nav.dart';
import 'package:foodsense_app/pages/detail_page.dart';
import 'package:foodsense_app/pages/home_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // ตัวอย่างข้อมูล
  final List<String> sections = ['Today', 'Yesterday', '7 Days Before'];
  final List<List<Map<String, dynamic>>> foodHistory = [
    [
      {'name': 'Pad thai', 'image': 'assets/icons/Pad_Thai.jpg'},
      {'name': 'Pad thai', 'image': 'assets/icons/Pad_Thai.jpg'},
      {'name': 'Pad thai', 'image': 'assets/icons/Pad_Thai.jpg'},
    ],
    [
      {'name': 'Pad thai', 'image': 'assets/icons/Pad_Thai.jpg'},
      {'name': 'Pad thai', 'image': 'assets/icons/Pad_Thai.jpg'},
    ],
    [
      {'name': 'Pad thai', 'image': 'assets/icons/Pad_Thai.jpg'},
      {'name': 'Pad thai', 'image': 'assets/icons/Pad_Thai.jpg'},
    ],
  ];

  List<List<bool>> isFavoriteList = [];

  @override
  void initState() {
    super.initState();
    isFavoriteList =
        foodHistory
            .map((section) => List.filled(section.length, false))
            .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 4),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Icon(Icons.arrow_back_ios_new),
                  ),
                  const Spacer(), // ดันทุกอย่างไปชิดขวา
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        'Thanakrit',
                        style: TextStyle(
                          fontFamily: 'Sora',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'My Account',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(
                      'assets/icons/profile_pic.jpg',
                    ), 
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: Text(
                  'History',
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: Divider(),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: sections.length,
                itemBuilder: (context, sectionIndex) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Title
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Text(
                          sections[sectionIndex],
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF9747FF),
                          ),
                        ),
                      ),

                      // Horizontal List
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          height: 180,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: foodHistory[sectionIndex].length,
                            itemBuilder: (context, index) {
                              final food = foodHistory[sectionIndex][index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: GestureDetector(
                                  // onTap: () {
                                  //   Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder:
                                  //           (context) => DetailPage(foodData: foodList[index]),
                                  //     ),
                                  //   );
                                  // },
                                  child: Container(
                                    width: 180,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                top: Radius.circular(16),
                                              ),
                                          child: Image.asset(
                                            food['image'],
                                            height: 130,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 13,
                                            vertical: 8,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  food['name'],
                                                  style: const TextStyle(
                                                    fontFamily: 'Sora',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isFavoriteList[sectionIndex][index] =
                                                        !isFavoriteList[sectionIndex][index];
                                                  });
                                                },
                                                child: Image.asset(
                                                  isFavoriteList[sectionIndex][index]
                                                      ? 'assets/icons/heart_red.png'
                                                      : 'assets/icons/heart_black.png',
                                                  width: 22,
                                                  height: 22,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
