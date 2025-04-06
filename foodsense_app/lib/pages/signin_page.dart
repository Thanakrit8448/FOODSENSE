import 'package:flutter/material.dart';
import 'package:foodsense_app/main.dart';
import 'package:foodsense_app/pages/signup_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool isPasswordVisible = false;
  //bool isConfirmPasswordVisible = false;
  bool isLinkPressed = false;

  //Make a Controller
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                  'Hello Sign IN!',
                  style: TextStyle(
                    fontFamily: 'Caveat',
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFAD6FFF),
                  ),
                ),
                SizedBox(height: 40),
                _buildTextField(label: 'Username', controller: usernameController),
                //_buildTextField(label: 'Email'),
                _buildTextField(label: 'Password', controller: passwordController, obscureText: !isPasswordVisible, isPassword: true),
                //_buildTextField(label: 'Confirm Password', obscureText: !isConfirmPasswordVisible, isPassword: true, isConfirmPassword: true),
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
                    onPressed: () async {
                      

                      //Press to send Data to DB
                      final username = usernameController.text.trim();
                      final password = passwordController.text;

                      try{
                        final response = await Supabase.instance.client.auth.signInWithPassword(
                            //email is username in this field
                            email: username,
                            password: password
                          );


                        final user = response.user;

                        if(user != null){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Sign in Successful'))
                          );


                          Navigator.pushReplacement(
                          context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        }

                        else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Sign in Unsuccessful'))
                          );
                        }
                      }

                      catch(error){
                        String message = 'Sign in Unsuccessful';

                        if(error is AuthException){
                          message = error.message;
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(message))
                        );
                      }
                    },
                    child: Text(
                      'SIGN IN',
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
                      MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    child: Text(
                      'Do you have account? SIGN UP',
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

  Widget _buildTextField({required String label, required TextEditingController controller, bool obscureText = false, bool isPassword = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
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
                    isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Color(0xFF717171),
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}

