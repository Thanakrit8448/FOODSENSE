import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:foodsense_app/pages/bottom_nav.dart';
import 'package:foodsense_app/pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:foodsense_app/pages/detail_page.dart';
import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  

  File? _selectedImage;

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }


Future<void> analyzeImage() async {
  if (_selectedImage == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please select an image first')),
    );
    return;
  }

  final predictedName = await predictFoodNameFromImage(_selectedImage!);

  if (predictedName == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Failed to predict food name")),
    );
    return;
  }

  try {
    final response = await Supabase.instance.client
        .from('food_items')
        .select()
        .eq('name', predictedName)
        .single();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(foodData: response, fromCameraPage: true),
      ),
    );
  } 
  
  
  catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Not found in database: $predictedName")),
    );
  }
}


Future<String?> predictFoodNameFromImage(File imageFile) async {
  final bytes = await imageFile.readAsBytes();
  final base64Image = base64Encode(bytes);

  final url = Uri.parse("https://api.openai.com/v1/chat/completions");
  final apiKey = "" ; // <- Add you own openai api key

  final headers = {
    "Authorization": "Bearer $apiKey",
    "Content-Type": "application/json",
  };

  const foodNames = [
    "Khao Man Gai", "Pad Thai", "Tom Yum Goong", "Japanese Curry with Rice", "Katsudon",
    "Mango Sticky Rice", "Omelette", "Stir-fried Basil Pork with Rice", "Pad See Ew",
    "Thai Gravy Noodles", "Ramen", "Fried Chicken", "Fried Rice", "Boiled Rice",
    "Green Curry with Chicken", "Hamburger", "Tuna Sandwich", "Spaghetti Carbonara",
    "Salmon Sushi", "Pork Chop Steak"
  ];

  final prompt =
      "This is an image of food. From the 20 following menu items only, which dish is most likely shown in the image? Respond only in JSON like this: {\"label\": \"...\", \"confidence\": 0.xx }.\n\nChoices: ${foodNames.join(', ')}";

  final body = jsonEncode({
    "model": "gpt-4o",
    "messages": [
      {"role": "system", "content": "You are a food image classifier."},
      {
        "role": "user",
        "content": [
          {"type": "text", "text": prompt},
          {"type": "image_url", "image_url": {"url": "data:image/jpeg;base64,$base64Image"}}
        ]
      }
    ],
    "max_tokens": 100
  });

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final message = json['choices'][0]['message']['content'];
      print("➤ GPT raw reply: $message");

      final match = RegExp(r'{.*}').firstMatch(message);
      if (match == null) return null;

      final extracted = match.group(0)!;
      final parsed = jsonDecode(extracted);
      return parsed['label'];
    } 
    
    
    else {
      print("GPT error: ${response.body}");
      return null;
    }
  } 
  
  
  catch (error) {
    print("Error: $error");
    return null;
  }
}


 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Stack(
        children: [
          // Top bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 100,
              padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
              color: const Color(0xFF9747FF),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Center(
                    child: Text(
                      'Food Tacker',
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Sora',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                          (route) => false,
                        );
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Center message
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Please select a food image from your gallery.',
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Sora',
                  color: Colors.black,
                  
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Gallery button
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFF9747FF),
                  shape: BoxShape.circle,
                  
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.image, size: 48, color: Colors.white),
                      onPressed: _pickImageFromGallery,
                    ),
                    
                  ],
                ),
              ),
            ),
          ),

          // Start Analysis Button
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: analyzeImage, // TODO: เรียก API วิเคราะห์อาหาร
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9747FF),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'START ANALYSIS',
                style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 3),
    );
  }
}
