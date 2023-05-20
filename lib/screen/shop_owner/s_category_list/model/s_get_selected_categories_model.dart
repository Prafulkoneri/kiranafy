class GetSelectedCategoryResponseModel {
  int? status;
  String? message;
  List<SelectedCategoryData>? data;

  GetSelectedCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    if (json["data"] != null) {
      data = <SelectedCategoryData>[];
      json["data"].forEach((v) {
        data!.add(SelectedCategoryData.fromJson(v));
      });
    }
  }

  GetSelectedCategoryResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });
}

class SelectedCategoryData {
  int? id;
  String? categoryName;
  int? categorySequence;
  String? categoryImagePath;
  String? categoryImageName;

  SelectedCategoryData({
    required this.id,
    required this.categoryName,
    required this.categorySequence,
    required this.categoryImagePath,
    required this.categoryImageName,
  });

  SelectedCategoryData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    categoryName = json["category_name"];
    categorySequence = json["category_sequence"];
    categoryImagePath = json["category_image_path"];
    categoryImageName = json["category_image_name"];
  }
}