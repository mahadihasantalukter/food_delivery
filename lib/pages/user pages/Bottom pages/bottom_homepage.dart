import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/pages/user%20pages/Bottom%20pages/page/buy_and%20_add_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

class BottomHomepage extends StatefulWidget {
  final String username;
  const BottomHomepage({super.key, required this.username});

  @override
  State<BottomHomepage> createState() => _BottomHomepageState();
}

class _BottomHomepageState extends State<BottomHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: fetchproducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var product = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Get.offAll(
                      buyandaddpage(
                        product: product,
                        username: widget.username,
                      ),
                    );
                  },
                  child: Card(
                    elevation: 1,
                    shadowColor: const Color.fromARGB(249, 8, 176, 218),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(15),
                            ),
                            child: Image.network(
                              product['image_url'],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder:
                                  (context, error, stackTrace) => const Center(
                                    child: Icon(
                                      Icons.fastfood_outlined,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name: ${product['name']}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 2),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Price: ${product['price']} ৳",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<dynamic>> fetchproducts() async {
    final String url = "http://192.168.1.113/flutter/api/uploads.php";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      throw Exception("Failed to api load products");
    }
  }
}
