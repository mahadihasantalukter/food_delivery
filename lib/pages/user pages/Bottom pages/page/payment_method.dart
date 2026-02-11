import 'package:flutter/material.dart';
import 'package:food_delivery/pages/user%20pages/Bottom%20pages/bottom_homepage.dart';
import 'package:food_delivery/pages/user%20pages/Bottom%20pages/page/buy_and%20_add_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PaymentMethod extends StatefulWidget {
  final dynamic product;
  final String username;
  const PaymentMethod({super.key, this.product, required this.username});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBar(
        centerTitle: true,
        title: Text(
          "Payment Method",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.offAll(
              buyandaddpage(username: widget.username, product: widget.product),
            );
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
      ),
    );
  }
}
