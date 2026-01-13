import 'package:flutter/material.dart';

class AdminHomepage extends StatefulWidget {
  final String username;
  const AdminHomepage({super.key, required this.username});

  @override
  State<AdminHomepage> createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Admin Homepage", style: TextStyle(fontSize: 32),)));
  }
}
