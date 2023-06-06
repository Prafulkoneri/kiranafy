class FavProductResModel {
  int? status;
  String? message;
  FavProductData? data;

  FavProductResModel({
    required this.status,
    required this.message,
    required this.data,
  });
  FavProductResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json['data'] != null ? FavProductData.fromJson(json['data']) : null;
  }
}

class FavProductData {
  List<AdminProduct>? adminProducts;
  List<CustomeProduct>? customProducts;

  FavProductData({
    required this.adminProducts,
    required this.customProducts,
  });
  FavProductData.fromJson(Map<String, dynamic> json) {
    if (json["adminProducts"] != null) {
      adminProducts = <AdminProduct>[];
      json["adminProducts"].forEach((v) {
        adminProducts!.add(AdminProduct.fromJson(v));
      });
    }
    if (json["customProducts"] != null) {
      customProducts = <CustomeProduct>[];
      json["customProducts"].forEach((v) {
        customProducts!.add(CustomeProduct.fromJson(v));
      });
    }
  }
}

class AdminProduct {
  int? id;
  String? productName;
  String? productImagePath;
  String? productImageName;
  String? shopName;
  int? shopId;
  String? status;
  String? unit;
  String? weight;
  String? price;

  AdminProduct({
    required this.id,
    required this.productName,
    required this.productImagePath,
    required this.productImageName,
    required this.shopName,
    required this.shopId,
    required this.status,
    required this.unit,
    required this.weight,
    required this.price,
  });
  AdminProduct.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productName = json["product_name"];
    productImagePath = json["product_image_path"];
    productImageName = json["product_image_name"];
    shopName = json["shop_name"];
    shopId = json["shop_id"];
    status = json["status"];
    unit = json["unit"];
    weight = json["weight"];
    price = json["price"];
  }
}

class CustomeProduct {
  int? id;
  String? productName;
  String? productImagePath;
  String? productImageName;
  String? shopName;
  int? shopId;
  String? status;
  String? unit;
  String? weight;
  String? price;

  CustomeProduct({
    required this.id,
    required this.productName,
    required this.productImagePath,
    required this.productImageName,
    required this.shopName,
    required this.shopId,
    required this.status,
    required this.unit,
    required this.weight,
    required this.price,
  });
  CustomeProduct.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productName = json["product_name"];
    productImagePath = json["product_image_path"];
    productImageName = json["product_image_name"];
    shopName = json["shop_name"];
    shopId = json["shop_id"];
    status = json["status"];
    unit = json["unit"];
    weight = json["weight"];
    price = json["price"];
  }
}
