import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_delivery/pages/admin_pages/admin_drawer.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  final String username;
  const UploadPage({super.key, required this.username});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawer(username: widget.username),
      appBar: AppBar(),

      body: Container(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Upload product',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(255, 3, 221, 250),
                      ),
                    ),
                    labelText: 'Product name',
                    prefixIcon: Icon(
                      Icons.person_2_outlined,
                      color: Colors.black,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 18),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(255, 3, 221, 250),
                      ),
                    ),
                    labelText: 'Product description',
                    prefixIcon: Icon(
                      Icons.description_outlined,
                      color: Colors.black,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                  style: TextStyle(color: Colors.black),
                ),

                SizedBox(height: 18),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(255, 3, 221, 250),
                      ),
                    ),
                    labelText: 'Product Price',
                    prefixIcon: Icon(
                      Icons.price_change_outlined,
                      color: Colors.black,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 18),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(255, 3, 221, 250),
                      ),
                    ),
                    labelText: 'Product image',
                    prefixIcon: Icon(Icons.image_outlined, color: Colors.black),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image != null || _nameController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar()
    }
  }
}
