import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home:ImageUploadPage(),
    );
  }
}


class ImageUploadPage extends StatefulWidget {
  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  // Future<void> _uploadImage() async {
  //   if (_image == null) return;

  //   final uri = Uri.parse('https://your-server-url/upload'); // Replace with your server URL
  //   var request = http.MultipartRequest('POST', uri);
  //   request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

  //   try {
  //     var response = await request.send();

  //     if (response.statusCode == 200) {
  //       print('Image uploaded successfully.');
  //     } else {
  //       print('Image upload failed with status: ${response.statusCode}.');
  //     }
  //   } catch (e) {
  //     print('Image upload failed with error: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No image selected.')
                : Image.file(_image!),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: _uploadImage,
            //   child: Text('Upload Image'),
            // ),
          ],
        ),
      ),
    );
  }
}