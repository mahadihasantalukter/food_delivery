import 'package:flutter/material.dart';
import 'package:food_delivery/pages/homepage.dart';
import 'package:food_delivery/pages/user%20pages/login_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHomepage extends StatefulWidget {
  final String username;
  const AdminHomepage({super.key, required this.username});

  @override
  State<AdminHomepage> createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.black87,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.username,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ListTile(
              title: const Text(
                'Home',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              leading: Icon(Icons.home_outlined, color: Colors.white),
              onTap: () {
                Get.offAll(AdminHomepage(username: widget.username));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              logout();
            },
            icon: Icon(Icons.logout_outlined),
          ),
          SizedBox(width: 10),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notification_add_outlined),
          ),
        ],
      ),
      body: Container(
        height: 20,
        width: 20,
        alignment: Alignment.center,
        color: const Color.fromARGB(255, 226, 9, 9),
      ),
    );
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAll(LoginPage());
    print("Logout Success");
  }
}
