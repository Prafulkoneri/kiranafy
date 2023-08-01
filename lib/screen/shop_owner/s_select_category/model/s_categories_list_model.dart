class AllCategoryResponseModel {
  int? status;
  String? message;
  List<CategoryData>? data;

  AllCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    if (json["data"] != null) {
      data = <CategoryData>[];
      json["data"].forEach((v) {
        data!.add(CategoryData.fromJson(v));
      });
    }
  }

  AllCategoryResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });
}

class CategoryData {
  int? id;
  String? categoryName;
  int? categorySequence;
  String? categoryImagePath;
  String? categoryImageName;
  String? selectedByShopOwner;

  CategoryData({
    required this.id,
    required this.categoryName,
    required this.categorySequence,
    required this.categoryImagePath,
    required this.categoryImageName,
    required this.selectedByShopOwner,
  });

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    categoryName = json["category_name"];
    categorySequence = json["category_sequence"];
    categoryImagePath = json["category_image_path"];
    categoryImageName = json["category_image_name"];
    selectedByShopOwner = json["selected_by_shop_owner"];
  }
}
