class DashBoardModel {
  int? status;
  String? message;
  Data? data;

  DashBoardModel({
    required this.status,
    required this.message,
    required this.data,
  });

  DashBoardModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? categoriesCount;
  int? productsCount;

  Data({
    required this.categoriesCount,
    required this.productsCount,
  });
  Data.fromJson(Map<String, dynamic> json) {
    categoriesCount = json["categories_count"];
    productsCount = json["products_count"];
  }
}
