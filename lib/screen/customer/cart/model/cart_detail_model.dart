import '../../shop_profile/model/customer_view_shop_model.dart';

class CartDetailRequestModel {
  String? cartId;
  String? shopId;

  CartDetailRequestModel({
    this.cartId,
    this.shopId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["cart_id"] = cartId;
    data["shop_id"] = shopId;
    return data;
  }
}

////////////////////ResPonse Model//////////////////

class CartDetailResponseModel {
  int? status;
  String? message;
  CartDetailData? cartDetailData;

  CartDetailResponseModel({
    required this.status,
    required this.message,
    required this.cartDetailData,
  });
  CartDetailResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    cartDetailData =
        json['data'] != null ? CartDetailData.fromJson(json['data']) : null;
  }
}

class CartDetailData {
  ShopDetails? shopDetails;
  List<CartItemList>? cartItemList;

  CartDetailData({
    required this.shopDetails,
    required this.cartItemList,
  });
  CartDetailData.fromJson(Map<String, dynamic> json) {
    shopDetails = json['shop_details'] != null
        ? ShopDetails.fromJson(json['shop_details'])
        : null;
    if (json["cart_item_list"] != null) {
      cartItemList = <CartItemList>[];
      json["cart_item_list"].forEach((v) {
        cartItemList!.add(CartItemList.fromJson(v));
      });
    }
  }
}

class CartItemList {
  int? cartItemId;
  String? productName;
  String? productImagePath;
  String? productImageName;
  int? quantity;
  String? weight;
  String? offerPrice;
  String? mrpPrice;
  String? productType;
  String? discountPercentage;
  String? unit;

  CartItemList({
    required this.cartItemId,
    required this.productName,
    required this.productImagePath,
    required this.productImageName,
    required this.quantity,
    required this.weight,
    required this.offerPrice,
    required this.mrpPrice,
    required this.productType,
    required this.discountPercentage,
    required this.unit,
  });
  CartItemList.fromJson(Map<String, dynamic> json) {
    cartItemId = json["cart_item_id"];
    productName = json["product_name"];
    productImagePath = json["product_image_path"];
    productImageName = json["product_image_name"];
    quantity = json["quantity"];
    weight = json["weight"];
    offerPrice = json["offer_price"];
    mrpPrice = json["mrp_price"];
    productType = json["product_type"];
    discountPercentage = json["discount_percentage"];
    unit = json["unit"];
  }
}

// class ShopDetails {
//   int? id;
//   String? shopName;
//   String? shopAddress;
//   String? areaName;
//   String? cityName;
//   int? shopPincode;
//   String? shopOwnerSupportNumber;
//   String? isFavourite;

//   ShopDetails({
//     required this.id,
//     required this.shopName,
//     required this.shopAddress,
//     required this.areaName,
//     required this.cityName,
//     required this.shopPincode,
//     required this.shopOwnerSupportNumber,
//     required this.isFavourite,
//   });
//   ShopDetails.fromJson(Map<String, dynamic> json) {
//     id = json["id"];
//     shopName = json["shop_name"];
//     shopAddress = json["shop_address"];
//     areaName = json["area_name"];
//     cityName = json["city_name"];
//     shopPincode = json["shop_pincode"];
//     shopOwnerSupportNumber = json["shop_owner_support_number"];
//     isFavourite = json["is_favourite"];
//   }
// }
