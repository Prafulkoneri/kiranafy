class AllCategoriesReqModel {
  int? customerPincode;

  AllCategoriesReqModel({
    required this.customerPincode,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data["customer_pincode"] = customerPincode;

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

    if (json["data"] != null) {
      categories = <Category>[];
      json["data"].forEach((v) {
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
    categoryImageName = json["category_image_name"];
  }
}
