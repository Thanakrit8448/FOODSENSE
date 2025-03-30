import 'package:flutter/material.dart';
import 'package:foodsense_app/main.dart';
import 'package:foodsense_app/pages/signin_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isLinkPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAD6FFF),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Your\nAccount',
                  style: TextStyle(
                    fontFamily: 'Caveat',
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFAD6FFF),
                  ),
                ),
                SizedBox(height: 40),
                _buildTextField(label: 'Username'),
                _buildTextField(label: 'Email'),
                _buildTextField(label: 'Password', obscureText: !isPasswordVisible, isPassword: true, isConfirmPassword: false),
                _buildTextField(label: 'Confirm Password', obscureText: !isConfirmPasswordVisible, isPassword: true, isConfirmPassword: true),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 65,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFAD6FFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: GestureDetector(
                    onTapDown: (_) {
                      setState(() => isLinkPressed = true);
                    },
                    onTapUp: (_) {
                      setState(() => isLinkPressed = false);
                    },
                    onTapCancel: () {
                      setState(() => isLinkPressed = false);
                    },
                    onTap: () {
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SigninPage()),
                      );
                    },
                    child: Text(
                      'Do you have account? SIGN IN',
                      style: TextStyle(
                        fontSize: 16,
                        color: isLinkPressed ? Color(0xFFAD6FFF) : Color(0xFF717171),
                        decoration: isLinkPressed ? TextDecoration.underline : TextDecoration.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, bool obscureText = false, bool isPassword = false, bool isConfirmPassword = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF9747FF),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF717171)),
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    (isConfirmPassword ? isConfirmPasswordVisible : isPasswordVisible)
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Color(0xFF717171),
                  ),
                  onPressed: () {
                    setState(() {
                      if (isConfirmPassword) {
                        isConfirmPasswordVisible = !isConfirmPasswordVisible;
                      } else {
                        isPasswordVisible = !isPasswordVisible;
                      }
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
