import 'package:flutter/material.dart';
import 'package:food_delivery/pages/admin_pages/admin_drawer.dart';

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
      drawer: AdminDrawer(username: widget.username),
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

      body: Container(
        height: 20,
        width: 20,
        alignment: Alignment.center,
        color: const Color.fromARGB(255, 226, 9, 9),
      ),
    );
  }
}
