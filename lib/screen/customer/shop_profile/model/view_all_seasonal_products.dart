class AllSeasonalProductsReqModel {
  String? shopId;
  String? limit;
  String? offset;

  AllSeasonalProductsReqModel({this.shopId, this.limit, this.offset});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["shop_id"] = shopId;
    data["limit"] = limit;
    data["offset"] = offset;
    return data;
  }
}

////////////////RES

class ViewAllSeasonalProducts {
  int? status;
  String? message;
  Data? data;

  ViewAllSeasonalProducts({
    required this.status,
    required this.message,
    required this.data,
  });
  ViewAllSeasonalProducts.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<SeasonalProduct>? seasonalProducts;

  Data({
    required this.seasonalProducts,
  });
  Data.fromJson(Map<String, dynamic> json) {
    if (json["seasonal_products"] != null) {
      seasonalProducts = <SeasonalProduct>[];
      json["seasonal_products"].forEach((v) {
        seasonalProducts!.add(SeasonalProduct.fromJson(v));
      });
    }
  }
}

class SeasonalProduct {
  int? id;
  String? productName;
  String? productImagePath;
  String? productImageName;
  String? weight;
  String? offerPrice;
  String? mrpPrice;
  String? categoryId;
  String? productType;
  String? discountPercentage;
  int? productId;
  String? status;
  String? unit;

  SeasonalProduct({
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
  SeasonalProduct.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productName = json["product_name"];
    productImagePath = json["product_image_path"];
    productImageName = json["product_image_name"];
    weight = json["weight"];
    offerPrice = json["offer_price"];
    mrpPrice = json["mrp_price"];
    productId = json["product_id"];
    discountPercentage = json["discount_percentage"];
    status = json["status"];
    unit = json["unit"];
    categoryId = json['category_id'];
    productType = json["product_type"];
  }
}
