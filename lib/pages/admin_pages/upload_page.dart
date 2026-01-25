import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/admin_pages/admin_drawer.dart';
import 'package:http/http.dart' as http;
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

      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Container(
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
                    controller: _nameController,
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
                    controller: _descriptionController,
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
                    controller: _priceController,
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

                  _displayselectedimage(),
                  SizedBox(height: 18),
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 3, 221, 250),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    icon: Icon(Icons.image_outlined),
                    label: Text("Select image"),
                  ),
                  SizedBox(height: 18),
                  ElevatedButton.icon(
                    onPressed: _uploadImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 3, 221, 250),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    icon: Icon(Icons.upload_outlined),
                    label: Text("Upload image"),
                  ),
                ],
              ),
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
  Uint8List? _webimage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 1080,
      imageQuality: 85,
    );
    if (pickedImage != null) {
      if (kIsWeb) {
        final bytes = await pickedImage.readAsBytes();
        setState(() {
          _webimage = bytes;
          _image = null;
        });
      } else {
        setState(() {
          _image = File(pickedImage.path);
          _webimage = null;
        });
      }
    }
  }

  Widget _displayselectedimage() {
    if (kIsWeb && _webimage != null) {
      return Image.memory(_webimage!, height: 200);
    } else if (!kIsWeb && _image != null) {
      return Image.file(_image!, height: 200);
    } else {
      return const Text(
        "No image selected",
        style: TextStyle(color: Colors.black),
      );
    }
  }

  Future<void> _uploadImage() async {
    FocusScope.of(context).unfocus();
    if (_nameController.text.isEmpty || (_image == null && _webimage == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all the fields")),
      );
      return;
    }
    var uri = Uri.parse("http://192.168.1.105/flutter/api/uploads.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['name'] = _nameController.text;
    request.fields['description'] = _descriptionController.text;
    request.fields['price'] = _priceController.text;
    if (kIsWeb) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          _webimage!,
          filename: 'upload.jpg',
        ),
      );
    } else {
      var stream = http.ByteStream(_image!.openRead());
      var length = await _image!.length();
      var MultipartFile = http.MultipartFile(
        'image',
        stream,
        length,
        filename: (_image!.path),
      );
      request.files.add(MultipartFile);
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Product uploaded successfully")),
      );
      _nameController.clear();
      _descriptionController.clear();
      _priceController.clear();
      setState(() {
        _image = null;
        _webimage = null;
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Product upload failed")));
    }
  }
}
