import 'package:flutter/material.dart';
import 'package:foodsense_app/pages/signup_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key}); // ✅ เพิ่ม Constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAD6FFF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 70), 
              child: Text(
              'FOODSENSE',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 48,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                color: Colors.white,
              ),
            ),
          ),
          Spacer(),
            
            Text(
              'Welcome Back',
              style: TextStyle(
                fontFamily: 'Caveat',
                fontSize: 45,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 70,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: BorderSide(
                            color: Color(0xFFD091ED), //D091ED
                            width: 2.0),
                          
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFAD6FFF),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
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
                          MaterialPageRoute(builder: (context) => const SignupPage()),
                        );
                      },
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 350),
          ],
        ),
      ),
    );
  }
}
