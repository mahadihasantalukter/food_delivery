import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/pages/admin_pages/admin_homepage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(166, 63, 70, 1),
              const Color.fromARGB(255, 33, 36, 1),
              const Color.fromARGB(255, 0, 0, 0),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Admin Login Page',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "name",
                    hintStyle: TextStyle(color: Colors.white54),
                    prefixIcon: Icon(Icons.person, color: Colors.white54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                    hintStyle: TextStyle(color: Colors.white54),
                    prefixIcon: Icon(Icons.phone, color: Colors.white54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        login();
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Future<void> login() async {
    var url = Uri.parse('http://192.168.1.113/flutter/api/admin_login_reg.php');
    try {
      var response = await http.post(
        url,
        body: {
          'action': 'login',
          'name': nameController.text.trim(),
          'phone': phoneController.text.trim(),
        },
      );
      print("Raw Server Output: ${response.body}");
      if (response.statusCode == 200) {
        print("Response: ${response.body}");
        var data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          print(data['user']['name']);
          String userNameFromServer = data['user']['name'] ?? "No Name Found";
          String userphoneFromServer = data['user']['name'] ?? "No Name Found";

          await prefs.setString("user_name", userNameFromServer);
          await prefs.setString("user_phone", userphoneFromServer);
          await prefs.setString("role", 'admin');

          Get.offAll(AdminHomepage(username: data['user']['name']));
        } else {
          print(data['message']);
        }
      }
    } catch (e) {
      print("Eroor: $e");
    }
  }
}
