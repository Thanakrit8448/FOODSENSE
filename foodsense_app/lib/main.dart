import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://sospqlztlegdwhwvugfr.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNvc3BxbHp0bGVnZHdod3Z1Z2ZyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDMzMzk1OTQsImV4cCI6MjA1ODkxNTU5NH0.GQye91TKIJJfqQ6K7Ns3xQEF7BGlc2edTN6j3oY6YS0',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FOODSENSE',
      theme: ThemeData(
        primaryColor: Color(0xFFAD6FFF),
      ),
      home: const HomePage(), // เปลี่ยนจาก Scaffold เป็น HomePage()
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAD6FFF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Text(
              'FOODSENSE',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 48,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 0),
            Padding(
              padding: EdgeInsets.only(left: 70),
              child: Image.asset(
                'assets/icons/Logo.png',
                height: 270,
              ),
            ),
            const Spacer(),
            Text(
              'Smart food map Smart choices!',
              style: TextStyle(
                fontFamily: 'Caveat',
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            //const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                height: 70,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
