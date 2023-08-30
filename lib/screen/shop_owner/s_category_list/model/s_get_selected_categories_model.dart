class GetSelectedCategoryResponseModel {
  int? status;
  String? message;
  List<SelectedCategoryData>? selectedcategorydata;

  GetSelectedCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    if (json["data"] != null) {
      selectedcategorydata = <SelectedCategoryData>[];
      json["data"].forEach((v) {
        selectedcategorydata!.add(SelectedCategoryData.fromJson(v));
      });
    }
  }

  GetSelectedCategoryResponseModel({
    required this.status,
    required this.message,
    required this.selectedcategorydata,
  });
}

class SelectedCategoryData {
  int? id;
  int? categoryId;
  String? categoryName;
  int? categorySequence;
  String? categoryImagePath;
  String? categoryImageName;
  int? categoryCount;

  SelectedCategoryData({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.categorySequence,
    required this.categoryImagePath,
    required this.categoryImageName,
    required this.categoryCount,
  });

  SelectedCategoryData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    categoryId = json["category_id"];
    categoryName = json["category_name"];
    categorySequence = json["category_sequence"];
    categoryImagePath = json["category_image_path"];
    categoryImageName = json["category_image_name"];
    categoryCount = json["products_count"];
  }
}
