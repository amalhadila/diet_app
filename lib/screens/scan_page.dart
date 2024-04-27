import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

enum ImageUploadSource { gallery, camera }

class ScanPage extends StatefulWidget {
  ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  XFile? image;
  @override
  Future uploadimg({required ImageUploadSource source}) async {
    final ImagePicker picker = ImagePicker();
    var pickedimage = await picker.pickImage(
        source: source == ImageUploadSource.camera
            ? ImageSource.camera
            : ImageSource.gallery);

    if (pickedimage != null) {
      setState(() {
        image = XFile(pickedimage.path);
      });
    } else {}
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
                          uploadimg(source: ImageUploadSource.gallery);
                        },
                        icon: const Icon(
                          Icons.image_outlined,
                          size: 50,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () {
                          uploadimg(source: ImageUploadSource.camera);
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
