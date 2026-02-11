import 'package:flutter/material.dart';
import 'package:food_delivery/pages/homepage.dart';
import 'package:food_delivery/pages/user%20pages/Bottom%20pages/bottom_homepage.dart';
import 'package:food_delivery/pages/user%20pages/Bottom%20pages/page/payment_method.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

class buyandaddpage extends StatefulWidget {
  final String username;
  final dynamic product;
  const buyandaddpage({super.key, this.product, required this.username});

  @override
  State<buyandaddpage> createState() => _buyandaddpageState();
}

class _buyandaddpageState extends State<buyandaddpage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _addressController = TextEditingController();
    final TextEditingController _phoneController = TextEditingController();
    final TextEditingController _trxController = TextEditingController();
    String selectedMethod = "Bkash";
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.product["name"]),
        leading: IconButton(
          onPressed: () {
            Get.offAll(Homepage(username: widget.username));
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.product["image_url"]),
            SizedBox(height: 10),
            Text(
              "Price: ${widget.product["price"]}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(206, 209, 5, 56),
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.product["description"],
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
                    child: Icon(Icons.add_shopping_cart_outlined),
                  ),
                ),
                Text("Cart"),
              ],
            ),
            SizedBox(width: 15),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  addtocart();
                },
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
                onPressed: () {
                  Get.offAll(
                    PaymentMethod(
                      product: widget.product,
                      username: widget.username,
                    ),
                  );
                },
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

  Future<void> addtocart() async {
    var url = Uri.parse('http://192.168.1.119/flutter/api/add_to_cart.php');
    try {
      var response = await http.post(
        url,
        body: {
          "product_id": widget.product["id"].toString(),
          "username": widget.username,
          "name": widget.product["name"],
          "price": widget.product["price"].toString(),
          "image_url": widget.product["image_url"],
        },
      );
      print('Response: ${response.body}');
      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Product added to cart successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
