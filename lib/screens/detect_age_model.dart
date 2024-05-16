// To parse this JSON data, do
//
//     final detectAgeModel = detectAgeModelFromJson(jsonString);

import 'dart:convert';

DetectAgeModel detectAgeModelFromJson(String str) => DetectAgeModel.fromJson(json.decode(str));

String detectAgeModelToJson(DetectAgeModel data) => json.encode(data.toJson());

class DetectAgeModel {
    String status;
    Data data;

    DetectAgeModel({
        required this.status,
        required this.data,
    });

    factory DetectAgeModel.fromJson(Map<String, dynamic> json) => DetectAgeModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
    };
}

class Data {
    String result;

    Data({
        required this.result,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        result: json["result"],
    );

    Map<String, dynamic> toJson() => {
        "result": result,
    };
}
