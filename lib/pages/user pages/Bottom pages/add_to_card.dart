import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddToCard extends StatefulWidget {
  final String username;
  const AddToCard({super.key, required this.username});

  @override
  State<AddToCard> createState() => _AddToCardState();
}

class _AddToCardState extends State<AddToCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add To Card"), centerTitle: true),
      body: FutureBuilder<List>(
        future: getCartItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                value: 0.5,
                strokeWidth: 100,
                color: Color.fromARGB(255, 5, 215, 243),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var product = snapshot.data![index];
                return ListTile(
                  title: Text(product['name']),
                  subtitle: Text(product['price'].toString()),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List> getCartItems() async {
    var url = Uri.parse(
      "http://192.168.1.119/flutter/api/view_cart.php?username=${widget.username}",
    );
    var response = await http.get(url);
    return json.decode(response.body);
  }
}
