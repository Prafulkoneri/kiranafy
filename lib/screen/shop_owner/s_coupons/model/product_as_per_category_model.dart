////Request MOdel///////
class ProductAsPerCategoryReqModel {
  String? categoryId;

  ProductAsPerCategoryReqModel({
    this.categoryId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["category_id"] = categoryId;
    return data;
  }
}

///////////ResPonse Model////////////
class ProductAsPerCategoryResModel {
  int? status;
  String? message;
  List<ProductData>? data;

  ProductAsPerCategoryResModel({
    required this.status,
    required this.message,
    required this.data,
  });

  ProductAsPerCategoryResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    if (json["data"] != null) {
      data = <ProductData>[];
      json["data"].forEach((v) {
        data!.add(ProductData.fromJson(v));
      });
    }
  }
}

class ProductData {
  int? id;
  String? productName;
  String? productType;

  ProductData({
    required this.id,
    required this.productName,
    required this.productType,
  });

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productName = json["product_name"];
    productType = json["product_type"];
  }
}
