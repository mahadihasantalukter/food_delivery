import 'package:flutter/material.dart';
import 'package:food_delivery/pages/homepage.dart';
import 'package:food_delivery/pages/user%20pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool isloading = true;
  String? username;
 

  Future<void> checkLoginstatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("user_name");
      
      isloading = false;
    });
  }

  @override
  void initState() {
    checkLoginstatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isloading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return username == null ? LoginPage() : Homepage(username: username!);
  }
}
