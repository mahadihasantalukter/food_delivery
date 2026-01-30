import 'package:flutter/material.dart';
import 'package:food_delivery/pages/homepage.dart';
import 'package:food_delivery/pages/user%20pages/Bottom%20pages/bottom_homepage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class buyandaddpage extends StatelessWidget {
  final String username;
  final dynamic product;
  const buyandaddpage({super.key, this.product, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(product["name"]),
        leading: IconButton(
          onPressed: () {
            Get.offAll(Homepage(username: username));
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product["image_url"]),
            SizedBox(height: 10),
            Text(
              "Price: ${product["price"]}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(206, 209, 5, 56),
              ),
            ),
            SizedBox(height: 10),
            Text(
              product["description"],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  shadowColor: Colors.black,
                  child: InkWell(
                    splashColor: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: Icon(Icons.storefront_outlined),
                  ),
                ),
                Text("Store"),
              ],
            ),
            SizedBox(width: 15),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  shadowColor: Colors.black,
                  child: InkWell(
                    splashColor: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: Icon(Icons.add_shopping_cart_outlined),
                  ),
                ),
                Text("Cart"),
              ],
            ),
            SizedBox(width: 15),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: Text("Add to cart"),
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.white,
                ),
                child: Text("Buy Now"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
