import 'package:flutter/material.dart';

class BottomHomepage extends StatefulWidget {
  const BottomHomepage({super.key});

  @override
  State<BottomHomepage> createState() => _BottomHomepageState();
}

class _BottomHomepageState extends State<BottomHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Homepage dart")));
  }
}
