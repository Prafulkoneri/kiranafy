// class AllCategoriesReqModel {
//   String ? pincode;

//   AllCategoriesReqModel({
//     required this.pincode,
//   });

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};

//     data["pincode"] = pincode;

//     return data;
//   }
// }

/////Response Model

///////////////////////////////

class AllCategoriesResModel {
  int? status;
  String? message;
  List<CategoriesList>? categoriesFirstList;
  List<CategoriesList>? categoriesSecondList;

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
      categoriesFirstList = <CategoriesList>[];
      json["categories_first_list"].forEach((v) {
        categoriesFirstList!.add(CategoriesList.fromJson(v));
      });
    }
    if (json["categories_second_list"] != null) {
      categoriesSecondList = <CategoriesList>[];
      json["categories_second_list"].forEach((v) {
        categoriesSecondList!.add(CategoriesList.fromJson(v));
      });
    }
  }
}

class CategoriesList {
  int? id;
  String? categoryName;
  int? categorySequence;
  String? categoryImagePath;
  String? categoryImageName;

  CategoriesList({
    required this.id,
    required this.categoryName,
    required this.categorySequence,
    required this.categoryImagePath,
    required this.categoryImageName,
  });
  CategoriesList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    categoryName = json["category_name"];
    categorySequence = json["category_sequence"];
    categoryImagePath = json["category_image_path"];
    categoryImageName = json["category_image_name"];
  }
}
