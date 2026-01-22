import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/pages/admin_pages/admin_login_page.dart';
import 'package:food_delivery/pages/homepage.dart';
import 'package:food_delivery/pages/user%20pages/register_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 77, 97, 102),
              const Color.fromARGB(255, 26, 30, 31),
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
                  'Login with your account',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.white54),
                    prefixIcon: Icon(Icons.email, color: Colors.white54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    // ignore: deprecated_member_use
                    fillColor: Colors.white.withOpacity(0.3),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.white54),
                    prefixIcon: Icon(Icons.lock, color: Colors.white54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          214,
                          105,
                          3,
                        ).withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      onPressed: () {
                        login();
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?>',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(width: 15),
                    InkWell(
                      onTap: () {
                        Get.offAll(RegisterPage());
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: const Color.fromARGB(118, 248, 247, 246),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Or',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'You are now an admin?>',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        Get.offAll(AdminLoginPage());
                      },
                      child: Text(
                        'Admin Login',
                        style: TextStyle(
                          color: const Color.fromARGB(118, 248, 247, 246),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
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

  Future<void> login() async {
    var url = Uri.parse('http://192.168.1.106/flutter/api/user_login_reg.php');
    try {
      var response = await http.post(
        url,
        headers: {"Accept": "application/json"},
        body: {
          'action': 'login',
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
        },
      );
      if (response.statusCode == 200) {
        print("Response: ${response.body}");

        var data = jsonDecode(response.body);
        print("User Data: ${data['user']}");
        if (data['status'] == 'success') {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("user_email", data['user']['email']);
          await prefs.setString("user_name", data['user']['name']);
          await prefs.setString("role", 'user');

          Get.offAll(Homepage(username: data['user']['name']));
        } else {
          print(data['message']);
        }
      }
    } catch (e) {
      print("Eroor: $e");
    }
  }
}
