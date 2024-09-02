import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final ImagePickerController imagePickerController = Get.put(ImagePickerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<ImagePickerController>(
              builder: (_) {
                if (imagePickerController.imageFile == null) {
                  return Text('No image selected.');
                }
                return Image.file(imagePickerController.imageFile!);
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                imagePickerController.pickImage();
              },
              child: Text('Capture Image'),
            ),
          ],
        ),
      ),
    );
  }
}

class ImagePickerController extends GetxController {
  File? imageFile;
  final picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      update();
    }
  }
}
