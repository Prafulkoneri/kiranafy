class AllCategoriesReqModel {
  String ? pincode;

  AllCategoriesReqModel({
    required this.pincode,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data["pincode"] = pincode;

    return data;
  }
}

/////Response Model
class AllCategoriesResModel {
  int? status;
  String? message;
  List<Category>? categories;

  AllCategoriesResModel({
    required this.status,
    required this.message,
    required this.categories,
  });
  AllCategoriesResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];

    if (json["categories"] != null) {
      categories = <Category>[];
      json["categories"].forEach((v) {
        categories!.add(Category.fromJson(v));
      });
    }
  }
}

class Category {
  int? id;
  String? categoryName;
  int? categorySequence;
  String? categoryImagePath;
  String? categoryImageName;

  Category({
    required this.id,
    required this.categoryName,
    required this.categorySequence,
    required this.categoryImagePath,
    required this.categoryImageName,
  });
  Category.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    categoryName = json["category_name"];
    categorySequence = json["category_sequence"];
    categoryImagePath = json["category_image_path"];
    categoryImageName = json["category_image_path"];
  }
}
