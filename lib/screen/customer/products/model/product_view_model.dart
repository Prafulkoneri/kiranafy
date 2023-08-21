import 'package:flutter/cupertino.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';

class ProductViewRequestModel {
  String? shopId;
  String? categoryId;
  String? productId;
  String? productType;

  ProductViewRequestModel(
      {this.shopId, this.categoryId, this.productId, this.productType});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["shop_id"] = shopId;
    data["category_id"] = categoryId;
    data["product_id"] = productId;
    data["product_type"] = productType;
    return data;
  }
}

/////////////////ResModel//////////////
class ProductViewResponseModel {
  int? status;
  String? message;
  ProductViewData? data;

  ProductViewResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });
  ProductViewResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json['data'] != null ? ProductViewData.fromJson(json['data']) : null;
  }
}

class ProductViewData {
  ProductViewShopDetails? shopDetails;
  ProductDetails? productDetails;
  List<ProductUnitDetail>? productUnitDetails;
  List<CustomerProductData>? similarProducts;

  ProductViewData({
    required this.shopDetails,
    required this.productDetails,
    required this.productUnitDetails,
    required this.similarProducts,
  });
  ProductViewData.fromJson(Map<String, dynamic> json) {
    shopDetails = json['shop_details'] != null
        ? ProductViewShopDetails.fromJson(json['shop_details'])
        : null;

    productDetails = json['product_details'] != null
        ? ProductDetails.fromJson(json['product_details'])
        : null;

    if (json["product_unit_details"] != null) {
      productUnitDetails = <ProductUnitDetail>[];
      json["product_unit_details"].forEach((v) {
        productUnitDetails!.add(ProductUnitDetail.fromJson(v));
      });
    }

    if (json["similar_products"] != null) {
      similarProducts = <CustomerProductData>[];
      json["similar_products"].forEach((v) {
        similarProducts!.add(CustomerProductData.fromJson(v));
      });
    }
  }
}

class ProductViewShopDetails {
  String? id;
  String? shopName;
  String? areaName;
  String? cityName;
  String? shopAddress;
  int? shopPincode;
  String? shopOwnerSupportNumber;
  String? isFvrt;

  ProductViewShopDetails(
      {required this.id,
      required this.shopName,
      required this.areaName,
      required this.cityName,
      required this.shopAddress,
      required this.shopPincode,
      required this.shopOwnerSupportNumber,
      required this.isFvrt});
  ProductViewShopDetails.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    shopName = json["shop_name"];
    areaName = json["area_name"];
    cityName = json["city_name"];
    shopAddress = json["shop_address"];
    shopPincode = json["shop_pincode"];
    shopOwnerSupportNumber = json["shop_owner_support_number"];
    isFvrt = json["is_favourite"];
  }
}

class ProductDetails {
  int? id;
  String? productName;
  String? productImagePath;
  String? productImageName;
  String? categoryName;
  String? brandName;
  String? productDescription;
  String? productType;
  String? isProductFvrt;

  ProductDetails(
      {required this.id,
      required this.productName,
      required this.productImagePath,
      required this.productImageName,
      required this.categoryName,
      required this.brandName,
      required this.productDescription,
      required this.productType,
      required this.isProductFvrt});
  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productName = json["product_name"];
    productImagePath = json["product_image_path"];
    productImageName = json["product_image_name"];
    categoryName = json["category_name"];
    brandName = json["brand_name"];
    productDescription = json["product_description"];
    productType = json["product_type"];
    isProductFvrt = json['is_favourite'];
  }
}

class ProductUnitDetail {
  int? id;
  String? weight;
  String? offerPrice;
  String? mrpPrice;
  String? discountPercentage;
  String? unit;
  String? addToCartCheck;
  String? productType;
  int? cartItemId;
  int? quantity;
  int? productUnitId;

  ProductUnitDetail({
    required this.id,
    required this.weight,
    required this.offerPrice,
    required this.mrpPrice,
    required this.discountPercentage,
    required this.unit,
    required this.addToCartCheck,
    required this.productUnitId,
    required this.cartItemId,
    required this.productType,
    required this.quantity,
  });
  ProductUnitDetail.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    weight = json["weight"];
    offerPrice = json["offer_price"];
    mrpPrice = json["mrp_price"];
    discountPercentage = json["discount_percentage"];
    unit = json["unit"];
    addToCartCheck = json["add_to_cart_check"];
    productUnitId = json["product_unit_id"];
    cartItemId = json["cart_item_id"];
    productType = json["product_type"];
    quantity = json["quantity"];
  }
}
