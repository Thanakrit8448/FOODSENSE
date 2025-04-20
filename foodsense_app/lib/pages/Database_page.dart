import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodsense_app/pages/bottom_nav.dart';
import 'package:foodsense_app/pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabasePage extends StatefulWidget {
  const DatabasePage({super.key});

  @override
  State<DatabasePage> createState() => _DatabasePageState();
}

class _DatabasePageState extends State<DatabasePage> {
  //Make a Controler
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _caloriesDescController = TextEditingController();


  //Create function insertToCustomMenus to DB
  Future<void> insertToCustomMenus() async {
    final name = _nameController.text.trim();
    final desc = _descController.text.trim();
    //??
    final cal = double.tryParse(_caloriesController.text.trim()) ?? -1;
    final calDesc = _caloriesDescController.text.trim();

    if (name.isEmpty || cal<0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill name and calories"))
      );
      return;
    }

    try {
      await Supabase.instance.client
            .from('custom_menus')
            .insert({
              'name': name,
              'description': desc,
              'calories': cal,
              'calories_desc': calDesc,
            });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Added to Database succesfully"))
      );

      _nameController.clear();
      _descController.clear();
      _caloriesController.clear();
      _caloriesDescController.clear();

    }
    
    catch(error){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to insert: $error"))
      );
    }


  }
  
  String? username;

  Future<void> fetchProfile() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    try {
      final data = await Supabase.instance.client
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();

      setState(() {
        username = data['username'] ?? 'User';
      });
    } 
    
    
    catch (error) {
      debugPrint('Error fetching profile: $error');
    }
  }


  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  TextField buildRoundedTextField({
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    //??
    required TextEditingController controller,

  }) {
    return TextField(
      controller: controller,
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
                    children: [
                      Text(
                        username ?? 'Loading...',
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
                    backgroundImage: AssetImage('assets/icons/profile_pic2.jpg'),
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

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Text(
                'Note: This page is not for adding food to your history.\nIt is for adding new menu items to the database,\nwhich will be used in future updates.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.redAccent,
                  fontFamily: 'Sora',
                ),
                textAlign: TextAlign.center,
              ),
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
                    //Add controller
                    buildRoundedTextField(controller: _nameController),

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
                    //Add controller
                    buildRoundedTextField(maxLines: 4, controller: _descController),

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
                    //Add controller
                    buildRoundedTextField(keyboardType: TextInputType.number, controller: _caloriesController),

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
                    //Add controller
                    buildRoundedTextField(maxLines: 4, controller: _caloriesDescController),

                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        // onPressed: (insertToCustomMenus) {
                        //   //ไปไหนดีจ๊ะ เฟน
                        // },
                        onPressed: insertToCustomMenus,
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
