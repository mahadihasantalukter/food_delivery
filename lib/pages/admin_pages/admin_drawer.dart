import 'package:flutter/material.dart';
import 'package:food_delivery/pages/admin_pages/admin_homepage.dart';
import 'package:food_delivery/pages/admin_pages/upload_page.dart';
import 'package:food_delivery/pages/user%20pages/login_page.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AdminDrawer extends StatelessWidget {
  final String username;
  const AdminDrawer({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                    username,
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
              Get.offAll(AdminHomepage(username: username));
            },
          ),
          ListTile(
            title: Text(
              "Upload Menu",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            leading: Icon(Icons.upload_outlined, color: Colors.white),
            onTap: () {
              Get.offAll(UploadPage(username: username));
            },
          ),
          ListTile(
            title: Text(
              "Proofile ",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            leading: Icon(Icons.person_outlined, color: Colors.white),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "Orders List ",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            leading: Icon(Icons.list_alt_outlined, color: Colors.white),
            onTap: () {},
          ),

          ListTile(
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            leading: Icon(Icons.logout_outlined, color: Colors.white),
            onTap: () {
              logout();
            },
          ),
        ],
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
