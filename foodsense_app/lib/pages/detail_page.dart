import 'package:flutter/material.dart';
import 'package:foodsense_app/pages/home_page.dart';
import 'package:foodsense_app/pages/map_page.dart';
import 'package:foodsense_app/pages/database_page.dart';
import 'package:foodsense_app/pages/history_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DetailPage extends StatefulWidget {
  final Map<String, dynamic> foodData;
  final bool fromCameraPage;

  const DetailPage({super.key, required this.foodData, this.fromCameraPage = false});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isFavorite = false;

  Future<void> addToHistory() async {
  final userId = Supabase.instance.client.auth.currentUser?.id;
  final foodId = widget.foodData['id'];

  if (userId == null || foodId == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Missing user or food ID")),
    );
    return;
  }

  try {
    await Supabase.instance.client
        .from('user_food_logs')
        .insert({
          'user_id': userId,
          'food_id': foodId,
          'date': DateTime.now().toIso8601String(),
        });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Added to History!")),
    );

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HistoryPage()),
      (route) => false,
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Added to History!")),
      );
    });

  } 

  catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $error")),
    );
  }
}


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
                        child: Image.network(widget.foodData['image_url']),
                        //Image.asset('assets/icons/Pad_Thai.jpg'),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Title
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        widget.foodData['name'],
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        widget.foodData['description'],
                        style: TextStyle(color: Colors.grey, height: 1.5),
                      ),
                    ),

                    // Calories
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        '${widget.foodData['calories']} kcal',
                        style: TextStyle(
                          fontFamily: 'Sora',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    if (widget.fromCameraPage)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: addToHistory,
                            label: const Text("Add to History"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF9747FF),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                      ),



                    const SizedBox(height: 20),
                    if (widget.fromCameraPage)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const DatabasePage()),
                              );
                            },
                            label: const Text("Add Your Menu Into Our Database"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF9747FF),
                              side: const BorderSide(color: Color(0xFF9747FF), width: 2),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
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
