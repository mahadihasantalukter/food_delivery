import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/user%20pages/Bottom%20pages/page/payment_method.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddToCard extends StatefulWidget {
  final String username;
  final dynamic product;

  const AddToCard({super.key, required this.username, this.product});

  @override
  State<AddToCard> createState() => _AddToCardState();
}

class _AddToCardState extends State<AddToCard> {
  bool isLoading = true;
  List cartItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add To Card"), centerTitle: true),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  var product = cartItems[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: const Color.fromARGB(99, 33, 149, 243),
                        width: 1,
                      ),
                    ),
                    elevation: 8,
                    shadowColor: Colors.blue,

                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              image: DecorationImage(
                                image: NetworkImage(product['image']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5),
                                Text(
                                  "Name ${product['name']}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Price: ৳${product['price']}",
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              updateCart(
                                product['product_id'].toString(),
                                'remove',
                              );
                            },
                            icon: Icon(
                              Icons.remove_circle_outline,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "${product['quantity']}",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          IconButton(
                            onPressed: () {
                              updateCart(
                                product['product_id'].toString(),
                                'add',
                              );
                            },
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder:
                                    (context) => AlertDialog(
                                      title: Text("Are you sure?"),
                                      titleTextStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      content: Text(
                                        'Are you sure you want to delete this product?',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("No"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            deleteCartItem(
                                              product['product_id'].toString(),
                                            );
                                          },
                                          child: Text("Yes"),
                                        ),
                                      ],
                                    ),
                              );
                            },
                            icon: Icon(
                              Icons.delete_forever_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

      bottomNavigationBar:
          cartItems.isNotEmpty
              ? BottomAppBar(
                color: const Color.fromARGB(199, 255, 255, 255),
                child: Card(
                  color: Colors.orangeAccent,
                  elevation: 30,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.orange, width: 3),
                  ),
                  shadowColor: Colors.deepOrange,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: 90,

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total: ৳${CalculateTotal(cartItems).toString()}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            if (cartItems.isNotEmpty) {
                              Get.to(
                                () => PaymentMethod(
                                  username: widget.username,
                                  product: cartItems[0],
                                ),
                              );
                            }
                          },
                          child: Text("Buy Now"),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              : null,
    );
  }

  // Function to get cart items
  Future<void> getCartItems() async {
    var url = Uri.parse(
      "http://192.168.0.108/flutter/api/view_cart.php?username=${widget.username}",
    );
    var response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        cartItems = json.decode(response.body);
        isLoading = false;
      });
    }

    ;
  }

  // Function to delete cart

  Future<void> deleteCartItem(String productId) async {
    var url = Uri.parse("http://192.168.0.108/flutter/api/view_cart.php");
    var response = await http.post(
      url,
      body: {
        "product_id": productId,
        "username": widget.username,
        "action": "delete",
      },
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['status'] == 'success') {
        await getCartItems();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Product deleted successfully')));
      }
    }
  }

  // Function to update cart

  Future<void> updateCart(String productId, String action) async {
    var url = Uri.parse("http://192.168.0.108/flutter/api/view_cart.php");
    var response = await http.post(
      url,
      body: {
        "product_id": productId,
        "username": widget.username,
        "action": action,
      },
    );

    if (response.statusCode == 200) {
      await getCartItems();
    }
  }

  // Function to calculate total

  double CalculateTotal(List cartItems) {
    double total = 0;
    for (var item in cartItems) {
      total +=
          double.parse(item['price'].toString()) *
          int.parse(item['quantity'].toString());
    }
    return total;
  }
}
