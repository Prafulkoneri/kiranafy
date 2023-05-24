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
  List<Category>? categoriesFirstList;
  List<Category>? categoriesSecondList;

  AllCategoriesResModel({
    required this.status,
    required this.message,
    required this.categoriesFirstList,
    required this.categoriesSecondList,
  });
  AllCategoriesResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];

    if (json["categories_first_list"] != null) {
      categoriesFirstList = <Category>[];
      json["categories_first_list"].forEach((v) {
        categoriesFirstList!.add(Category.fromJson(v));
      });
    }
    if (json["categories_second_list"] != null) {
      categoriesSecondList = <Category>[];
      json["categories_second_list"].forEach((v) {
        categoriesSecondList!.add(Category.fromJson(v));
      });
    }
  }
}

class Category {
  int? id;
  String ? categorySelectedId;
  String? categoryName;
  int? categorySequence;
  String? categoryImagePath;
  String? categoryImageName;

  Category({
    required this.id,
    required this.categorySelectedId,
    required this.categoryName,

    required this.categorySequence,
    required this.categoryImagePath,
    required this.categoryImageName,
  });
  Category.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    categorySelectedId = json["category_selected_id"];
    categoryName = json["category_name"];
    categorySequence = json["category_sequence"];
    categoryImagePath = json["category_image_path"];
    categoryImageName = json["category_image_path"];
  }
}
