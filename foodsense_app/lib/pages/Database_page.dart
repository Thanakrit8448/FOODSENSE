import 'package:flutter/material.dart';
import 'package:foodsense_app/pages/bottom_nav.dart';
import 'package:foodsense_app/pages/home_page.dart';

class DatabasePage extends StatefulWidget {
  const DatabasePage({super.key});

  @override
  State<DatabasePage> createState() => _DatabasePageState();
}

class _DatabasePageState extends State<DatabasePage> {
  
  
  TextField buildRoundedTextField({
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    

  }) {
    return TextField(
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF9747FF), width: 2),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 2),
      body: SafeArea(
        child: Column(
          children: [
            // TopBar
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
                  const Spacer(),
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
                    backgroundImage: AssetImage('assets/icons/profile_pic.jpg'),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Center(
                child: Text(
                  'Database',
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    const SizedBox(height: 20),
                    const Text(
                      'Add Menu Name',
                      style: TextStyle(
                        color: Color(0xFF9747FF),
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    buildRoundedTextField(),

                    const SizedBox(height: 24),
                    const Text(
                      'Add Menu Description',
                      style: TextStyle(
                        color: Color(0xFF9747FF),
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    buildRoundedTextField(maxLines: 4),

                    const SizedBox(height: 24),
                    const Text(
                      'Total Calories',
                      style: TextStyle(
                        color: Color(0xFF9747FF),
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    buildRoundedTextField(keyboardType: TextInputType.number),

                    const SizedBox(height: 24),
                    const Text(
                      'Add Menu Calories Description',
                      style: TextStyle(
                        color: Color(0xFF9747FF),
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    buildRoundedTextField(maxLines: 4),

                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          //ไปไหนดีจ๊ะ เฟน
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF9747FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'ADD MENU TO DATABASE',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
    );
  }
}
