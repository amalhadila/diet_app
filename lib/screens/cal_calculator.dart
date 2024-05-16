import 'dart:io';

import 'package:diet/screens/cal_model.dart';
import 'package:diet/screens/info_page.dart';
import 'package:diet/screens/info_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class CalCalculator extends StatefulWidget {
  const CalCalculator({super.key});

  @override
  State<CalCalculator> createState() => _CalCalculatorState();
}

class _CalCalculatorState extends State<CalCalculator> {
    final Dio _dio = Dio();
  XFile? image;
  @override
  Future uploadImg() async {
    final ImagePicker picker = ImagePicker();
    var pickedimage = await picker.pickImage(
        source: ImageSource.gallery);

    if (pickedimage != null) {
      setState(() {
        image = XFile(pickedimage.path);
        uploadImageToServer(); 
      });
    } else {
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
        'https://age-aware-advisor.onrender.com/api/food-calories',
        data: formData,
      );

      CalModel calModel = CalModel.fromJson(response.data);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Calories Calculator"),
          content: Column(
            children: [
              Image.file(File(image!.path),fit: BoxFit.cover),
              SizedBox(height: 15),
              Text(calModel.data.result.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text("Number of calories: ${calModel.data.result.estimatedCalories}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              ),
              Text("${calModel.data.result.description}",),
            ],
          ),
        ),
      );
      //    Navigator.of(context).push(CupertinoPageRoute(builder: (context) => InfoPage(detectAgeModel: detectAgeModel),));

    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened $e, please try again"),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()async {await uploadImg();},
      child: Container(
        width: 310,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(21),
          color: Color.fromARGB(220, 214, 52, 71),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 95,
                width: 95,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    'assets/img/cal.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Calorie Counter',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
