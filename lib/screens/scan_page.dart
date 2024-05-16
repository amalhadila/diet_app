import 'dart:developer';

import 'package:diet/screens/info_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';

import 'detect_age_model.dart';

enum ImageUploadSource { gallery, camera }

class ScanPage extends StatefulWidget {
  ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final Dio _dio = Dio();
  XFile? image;
  @override
  Future uploadImg({required ImageUploadSource source}) async {
    log("selecting image started");
    final ImagePicker picker = ImagePicker();
    var pickedimage = await picker.pickImage(
        source: source == ImageUploadSource.camera
            ? ImageSource.camera
            : ImageSource.gallery);

    if (pickedimage != null) {
          log("selected image ");

      setState(() {
        image = XFile(pickedimage.path);
        uploadImageToServer(); 
      });
    } else {
                log(" image ins NULL");

            showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("Failed to upload image, please try again"),
        ),
      );
    }
  }
   Future<void> uploadImageToServer() async {
              log("starting uploading image to server");

    try {
      var formData = FormData.fromMap({
        'photo': await MultipartFile.fromFile(image!.path,
            filename: "photo", contentType: MediaType('image', 'jpeg')),
      });
      var response = await _dio.post(
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data'
          },
        ),
        'https://age-aware-advisor.onrender.com/api/estimate',
        data: formData,
      );
                    log(" uploaded image to server");

      DetectAgeModel detectAgeModel =
          DetectAgeModel.fromJson(response.data);
          Navigator.of(context).push(CupertinoPageRoute(builder: (context) => InfoPage(detectAgeModel: detectAgeModel),));

    } catch (e) {
                    log("failed to upload image to server");

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened $e, please try again"),
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21),
                color: const Color.fromARGB(220, 235, 111, 9),
              ),
              child: const Center(
                child: Text(
                  'Face Age Estimator',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 550,
              width: 350,
              decoration: BoxDecoration(
                  border: Border.all(
                      style: BorderStyle.solid,
                      color: const Color.fromARGB(255, 235, 145, 43))),
              child: image == null
                  ? const Center(child: Text('Upload Your Image'))
                  : Image.file(
                      File(image!.path),
                      fit: BoxFit.fill,
                    ),
            ),
            const SizedBox(
              height: 60,
            ),
            Container(
              height: 70,
              width: 380,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          uploadImg(source: ImageUploadSource.gallery);
                        },
                        icon: const Icon(
                          Icons.image_outlined,
                          size: 50,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () {
                          uploadImg(source: ImageUploadSource.camera);
                        },
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                          size: 50,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
