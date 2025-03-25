import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false, //ปิดแทบ debug ขวาบน
      title: 'FOODSENSE',
      theme: ThemeData(
        primaryColor: Color(0xFFAD6FFF),
      ),
      home: Scaffold(
        backgroundColor: Color(0xFFAD6FFF),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text('FOODSENSE',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 40),
                child: Image.asset(
                  'assets/icons/Logo.png',
                  height: 200,
                ),
              ),
              // const SizedBox(height: 10),
              // Text('Smart food map Smart choices!',
              //   style: TextStyle(
              //     fontSize: 16,
              //     fontStyle: FontStyle.italic,
              //     color: Colors.white, 
              //   ),
              // ),
              const Spacer(),

              //const SizedBox(height: 10),
              Text('Smart food map Smart choices!',
                style: TextStyle(
                  fontFamily: 'Caveat',
                  fontSize: 24,
                  // fontStyle: FontStyle.italic,
                  color: Colors.white, 
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 65,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      )
                    ),
                    onPressed: () {},
                    child: Text(
                      'Get Strated',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )
                    ),
                  )
                ),)
            ],
          ),
        ),
      ),
    );
  }
}
