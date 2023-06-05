class RecommandedReqModel {
  String? shopId;
  String? limit;
  String? offset;

  RecommandedReqModel({this.shopId, this.limit, this.offset});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["shop_id"] = shopId;
    data["limit"] = limit;
    data["offset"] = offset;

    return data;
  }
}

/////////RES MODEL/////////////

class RecommandedResModel {
  int? status;
  String? message;
  Data? data;

  RecommandedResModel({
    required this.status,
    required this.message,
    required this.data,
  });
  RecommandedResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<RecommandedProduct>? recommandedProducts;

  Data({
    required this.recommandedProducts,
  });
  Data.fromJson(Map<String, dynamic> json) {
    if (json["recommanded_products"] != null) {
      recommandedProducts = <RecommandedProduct>[];
      json["recommanded_products"].forEach((v) {
        recommandedProducts!.add(RecommandedProduct.fromJson(v));
      });
    }
  }
}

class RecommandedProduct {
  int? id;
  String? productName;
  String? productImagePath;
  String? productImageName;
  String? weight;
  String? offerPrice;
  String? mrpPrice;
  int? categoryId;
  String? productType;
  String? discountPercentage;
  int? productId;
  String? status;
  String? unit;

  RecommandedProduct({
    required this.id,
    required this.productName,
    required this.productImagePath,
    required this.productImageName,
    required this.weight,
    required this.offerPrice,
    required this.mrpPrice,
    required this.productType,
    required this.categoryId,
    required this.discountPercentage,
    required this.productId,
    required this.status,
    required this.unit,
  });

  RecommandedProduct.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productName = json["product_name"];
    productImagePath = json["product_image_path"];
    productImageName = json["product_image_name"];
    weight = json["weight"];
    offerPrice = json["offer_price"];
    mrpPrice = json["mrp_price"];
    categoryId = json['category_id'];
    productType = json["product_type"];
    discountPercentage = json["discount_percentage"];
    productId = json["product_id"];
    status = json["status"];
    unit = json["unit"];
  }
}
