import 'dart:convert';

class CustomerViewShopReqModel {
  String? shopId;

  CustomerViewShopReqModel({
    this.shopId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["shop_id"] = shopId;
    return data;
  }
}

class CustomerViewShopResModel {
  int? status;
  String? message;
  ShopData? data;

  CustomerViewShopResModel({
    required this.status,
    required this.message,
    required this.data,
  });
  CustomerViewShopResModel.fromJson(Map<String,dynamic>json){
    status=json["status"];
    message=json["message"];
    data = json['data'] != null ? ShopData.fromJson(json['data']) : null;
  }
}

class ShopData {
  ShopDetails? shopDetails;
  List<ShopCategory>? shopCategories;

  ShopData({
    required this.shopDetails,
    required this.shopCategories,
  });
  ShopData.fromJson(Map<String,dynamic>json){
    shopDetails = json['shop_details'] != null ? ShopDetails.fromJson(json['shop_details']) : null;
    if (json["shop_categories"] != null) {
      shopCategories = <ShopCategory>[];
      json["shop_categories"].forEach((v) {
        shopCategories!.add(ShopCategory.fromJson(v));
      });
    }

  }
}

class ShopCategory {
  int? id;
  String? categoryName;
  String? categoryImagePath;
  String? categoryImageName;
  int? categorySequence;

  ShopCategory({
    required this.id,
    required this.categoryName,
    required this.categoryImagePath,
    required this.categoryImageName,
    required this.categorySequence,
  });
  ShopCategory.fromJson(Map<String,dynamic>json){
    id=json["id"];
    categoryName=json["category_name"];
    categoryImagePath=json["category_image_path"];
    categoryImageName=json["category_image_name"];
    categorySequence=json["category_sequence"];
  }
}

class ShopDetails {
  int? id;
  String? shopName;
  String? cityName;
  String? areaName;
  int? shopPincode;
  String? shopAddress;
  String? shopOwnerSupportNumber;
  String? shopOwnerShopOpeningTime;
  String? shopOwnerShopCloseTime;
  String? shopOpenStatus;

  ShopDetails({
    required this.id,
    required this.shopName,
    required this.cityName,
    required this.areaName,
    required this.shopPincode,
    required this.shopAddress,
    required this.shopOwnerSupportNumber,
    required this.shopOwnerShopOpeningTime,
    required this.shopOwnerShopCloseTime,
    required this.shopOpenStatus,
  });
  ShopDetails.fromJson(Map<String,dynamic>json){
    id=json["id"];
    shopName=json["shop_name"];
    cityName=json["city_name"];
    areaName=json["area_name"];
    shopPincode=json["shop_pincode"];
    shopAddress=json["shop_address"];
    shopOwnerSupportNumber=json["shop_owner_support_number"];
    shopOwnerShopOpeningTime=json["shop_owner_shop_opening_time"];
    shopOwnerShopCloseTime=json["shop_owner_shop_close_time"];
    shopOpenStatus=json["shop_open_status"];
  }
}
