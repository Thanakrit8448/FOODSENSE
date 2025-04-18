import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foodsense_app/pages/login_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:foodsense_app/pages/bottom_nav.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentAdIndex = 0;
  Timer? _adTimer;

  //Create List retrieve Food Data from supabase
  List<Map<String, dynamic>> foodList = [];

  //Retrieve Food Data by select()
  Future<void> fetchFoodItem() async {
    final response = await Supabase.instance.client
          .from('food_items')
          .select()
          .order('created_at', ascending: false)
          .limit(6);

    setState(() {
      foodList = List<Map<String, dynamic>>.from(response);
    });
  }

  @override
  void initState() {
    super.initState();
    _startAdRotation();
    fetchFoodItem();
  }


  final List<String> adImages = [
    'assets/icons/ad1.png',
    'assets/icons/ad2.jpg',
    'assets/icons/ad3.jpg',
    'assets/icons/ad4.jpg',
  ];

  final List<bool> isFavoriteList = List.generate(6, (_) => false);
  final ImagePicker _picker = ImagePicker();

  File? _profileImage;
  final TextEditingController _nameController = TextEditingController(
    text: "Thanakrit",
  );
  final TextEditingController _emailController = TextEditingController(
    text: "thanakrit.oue@student.mahidol.edu",
  );

  void _startAdRotation() {
    _adTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (!mounted) return;
      setState(() {
        _currentAdIndex = (_currentAdIndex + 1) % adImages.length;
      });
    });
  }

  void _showProfileOverlay() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.white,
            child: Container(
              padding: const EdgeInsets.all(20),
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => Navigator.of(context).pop(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/icons/close_red.png',
                          width: 50,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(66, 0, 0, 0),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        final pickedFile = await _picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (pickedFile != null) {
                          setState(() {
                            _profileImage = File(pickedFile.path);
                          });
                        }
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage:
                            _profileImage != null ? FileImage(_profileImage!) : null,
                        child: _profileImage == null
                            ? const Icon(
                                Icons.face,
                                size: 40,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Username
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Username",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF9747FF),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          _nameController.text,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Email
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF9747FF),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          _emailController.text,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => LoginPage()),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _adTimer?.cancel();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFAD6FFF),
        elevation: 50,
        toolbarHeight: 180,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding( // Use Padding to apply margin
              padding: const EdgeInsets.only(left: 8, top: 130, bottom: 150), // Adjusted top padding
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                    onTap: _showProfileOverlay,
                    child: Image.asset(
                      'assets/icons/setting.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(-2, -120),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "FOODSENSE",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 165, 104, 246),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x40000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (
                      Widget child,
                      Animation<double> animation,
                    ) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: Image.asset(
                      adImages[_currentAdIndex],
                      key: ValueKey<String>(adImages[_currentAdIndex]),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 10),
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Recommend",
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      //itemCount: 6,
                      itemCount: foodList.take(6).length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Container(
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [
                                BoxShadow(color: Colors.black12, blurRadius: 5),
                              ],
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                  child: 
                                  //Change Image assert to Image network
                                  Image.network(
                                    foodList[index]['image_url'],
                                    height: 180,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                                    loadingBuilder: (context, child, progress) {
                                      if (progress == null) return child;
                                      return const Center(child: CircularProgressIndicator());
                                    },
                                  )
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(child: 
                                      Text(//Deleted const
                                        foodList[index]['name'],
                                        style: TextStyle(
                                          fontFamily: 'Sora',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isFavoriteList[index] =
                                                !isFavoriteList[index];
                                          });
                                        },
                                        child: Image.asset(
                                          isFavoriteList[index]
                                              ? 'assets/icons/heart_red.png'
                                              : 'assets/icons/heart_black.png',
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 0),
    );
  }
}