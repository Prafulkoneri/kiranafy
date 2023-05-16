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
    json["id"] = id;
    json["category_name"] = categoryName;
    json["category_sequence"] = categorySequence;
    json["category_image_path"] = categoryImagePath;
    json["category_image_name"] = categoryImageName;
    json["selected_by_shop_owner"] = selectedByShopOwner;
  }
}
