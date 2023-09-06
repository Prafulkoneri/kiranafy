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
  List<AdminProduct>? customProducts;

  FavProductData({
    required this.adminProducts,
    required this.customProducts,
  });
  FavProductData.fromJson(Map<String, dynamic> json) {
    if (json["admin_products"] != null) {
      adminProducts = <AdminProduct>[];
      json["admin_products"].forEach((v) {
        adminProducts!.add(AdminProduct.fromJson(v));
      });
    }
    if (json["custom_products"] != null) {
      customProducts = <AdminProduct>[];
      json["custom_products"].forEach((v) {
        customProducts!.add(AdminProduct.fromJson(v));
      });
    }
  }
}

class AdminProduct {
  int? id;
  int? categoryId;
  String? productName;
  String? productImagePath;
  String? productImageName;
  String? shopName;
  int? shopId;
  String? productType;
  int? productUnitId;
  String? status;
  String? unit;
  String? weight;
  String? price;

  AdminProduct({
    required this.id,
    required this.categoryId,
    required this.productName,
    required this.productImagePath,
    required this.productImageName,
    required this.shopName,
    required this.shopId,
    required this.productType,
    required this.productUnitId,
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
    categoryId = json["category_id"];
    productType = json["product_type"];
    productUnitId = json["product_unit_id"];
    status = json["status"];
    unit = json["unit"];
    weight = json["weight"];
    price = json["price"];
  }
}

class CustomeProduct {
  int? id;
  int? categoryId;
  String? productName;
  String? productImagePath;
  String? productImageName;
  String? shopName;
  int? shopId;
  String? productType;
  int? productUnitId;
  String? status;
  String? unit;
  String? weight;
  String? price;

  CustomeProduct({
    required this.id,
    required this.categoryId,
    required this.productName,
    required this.productImagePath,
    required this.productImageName,
    required this.shopName,
    required this.shopId,
    required this.productType,
    required this.productUnitId,
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
    categoryId = json["category_id"];
    productType = json["product_type"];
    productUnitId = json["product_unit_id"];
    status = json["status"];
    unit = json["unit"];
    weight = json["weight"];
    price = json["price"];
  }
}
