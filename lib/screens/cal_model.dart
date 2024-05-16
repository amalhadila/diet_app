class CalModel {
    String status;
    CalData data;

    CalModel({
        required this.status,
        required this.data,
    });

    factory CalModel.fromJson(Map<String, dynamic> json) => CalModel(
        status: json["status"],
        data: CalData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
    };
}

class CalData {
    CalResult result;

    CalData({
        required this.result,
    });

    factory CalData.fromJson(Map<String, dynamic> json) => CalData(
        result: CalResult.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "result": result.toJson(),
    };
}

class CalResult {
    String name;
    String estimatedCalories;
    String description;

    CalResult({
        required this.name,
        required this.estimatedCalories,
        required this.description,
    });

    factory CalResult.fromJson(Map<String, dynamic> json) => CalResult(
        name: json["name"],
        estimatedCalories: json["estimated_calories"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "estimated_calories": estimatedCalories,
        "description": description,
    };
}
