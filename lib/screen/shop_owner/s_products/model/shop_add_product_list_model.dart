////Request Model
class ShopAddProductsListRequestModel {
  String? category_id;

  ShopAddProductsListRequestModel({
    this.category_id,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["category_id"] = category_id;
    return data;
  }
}

////Response Model
class ShopAddProductsListResponse {
  int? status;
  String? message;
  Data? data;

  ShopAddProductsListResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  ShopAddProductsListResponse.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];

    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? categoryName;
  int? allProductsCount;
  List<ProductDetail>? productDetails;

  Data({
    required this.allProductsCount,
    this.categoryName,
    required this.productDetails,
  });

  Data.fromJson(Map<String, dynamic> json) {
    categoryName = json["category_name"];
    allProductsCount = json['all_products_count'];
    // productDetails = json['product_details'];

    if (json["product_details"] != null) {
      productDetails = <ProductDetail>[];
      json["product_details"].forEach((v) {
        productDetails!.add(ProductDetail.fromJson(v));
      });
    }
  }
}

class ProductDetail {
  int? id;
  String? productName;
  String? productImagePath;
  String? selectedByShopOwner;
  String? unitWithWeight;

  ProductDetail({
    required this.id,
    required this.productName,
    required this.productImagePath,
    required this.selectedByShopOwner,
    required this.unitWithWeight,
  });

  ProductDetail.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productName = json["product_name"];
    productImagePath = json["product_image_path"];
    selectedByShopOwner = json["selected_by_shop_owner"];
    unitWithWeight = json["unit_with_weight"];
  }
}
