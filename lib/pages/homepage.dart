import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/user%20pages/Bottom%20pages/add_to_card.dart';
import 'package:food_delivery/pages/user%20pages/Bottom%20pages/bottom_homepage.dart';
import 'package:food_delivery/pages/user%20pages/Bottom%20pages/profile.dart';
import 'package:food_delivery/pages/user%20pages/Bottom%20pages/setting.dart';

class Homepage extends StatefulWidget {
  final String username;
  const Homepage({super.key, required this.username});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int cuttentTableIndex = 0;
  final List<Widget> tableNames = [
    BottomHomepage(),
    AddToCard(),
    Profile(),
    Setting(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${widget.username}"),

        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined)),
          SizedBox(width: 10),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notification_add_outlined),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.blue,
        height: 60,
        animationDuration: Duration(milliseconds: 200),
        index: cuttentTableIndex,
        onTap: (index) {
          setState(() {
            cuttentTableIndex = index;
          });
        },

        color: Colors.white,
        items: <Widget>[
          Icon(Icons.home_outlined, size: 30),
          Icon(Icons.add_shopping_cart, size: 30),
          Icon(Icons.person_2_outlined),
          Icon(Icons.settings_outlined),
        ],
      ),

      body: tableNames[cuttentTableIndex],
    );
  }
}
