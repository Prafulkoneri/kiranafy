class SAddCategoriesReqModel {
  String? categoryId;

  SAddCategoriesReqModel({
    this.categoryId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["category_id"] = categoryId;
    return data;
  }
}

class SAddCategoriesResModel {
  int? status;
  String? message;

  SAddCategoriesResModel({
    this.status,
    this.message,
  });

  SAddCategoriesResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
