class AllProductsReqModel {
  String? shopId;
  String? limit;
  String? offset;

  AllProductsReqModel({this.shopId, this.limit, this.offset});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["shop_id"] = shopId;
    data["limit"] = limit;
    data["offset"] = offset;

    return data;
  }
}

/////ResponseMOdel Offere Products////////////
class ViewAllOfferProducts {
  int? status;
  String? message;
  Data? data;

  ViewAllOfferProducts({
    required this.status,
    required this.message,
    required this.data,
  });
  ViewAllOfferProducts.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<AllOfferProducts>? offerProducts;

  Data({
    required this.offerProducts,
  });
  Data.fromJson(Map<String, dynamic> json) {
    if (json["offer_products"] != null) {
      offerProducts = <AllOfferProducts>[];
      json["offer_products"].forEach((v) {
        offerProducts!.add(AllOfferProducts.fromJson(v));
      });
    }
  }
}

class AllOfferProducts {
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

  AllOfferProducts({
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

  AllOfferProducts.fromJson(Map<String, dynamic> json) {
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
