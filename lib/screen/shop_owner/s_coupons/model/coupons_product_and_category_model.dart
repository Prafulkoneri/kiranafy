////Request MOdel///////
class CouponsForProductAndCategoryRequestModel {
  String? categoryId;

  CouponsForProductAndCategoryRequestModel({
    this.categoryId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["category_id"] = categoryId;
    return data;
  }
}

///////////ResPonse Model////////////
class CouponsForProductAndCategoryResModel {
  int? status;
  String? message;
  List<CouponsData>? data;

  CouponsForProductAndCategoryResModel({
    required this.status,
    required this.message,
    required this.data,
  });
  CouponsForProductAndCategoryResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    if (json["data"] != null) {
      data = <CouponsData>[];
      json["data"].forEach((v) {
        data!.add(CouponsData.fromJson(v));
      });
    }
  }
}

class CouponsData {
  int? id;
  String? productName;
  String? productType;

  CouponsData({
    required this.id,
    required this.productName,
    required this.productType,
  });
  CouponsData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productName = json["product_name"];
    productType = json["product_type"];
  }
}
