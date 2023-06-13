class CartListModel {
  int? status;
  String? message;
  CartData? cartData;

  CartListModel({
    required this.status,
    required this.message,
    required this.cartData,
  });
  CartListModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    cartData = json['data'] != null ? CartData.fromJson(json['data']) : null;
  }
}

class CartData {
  List<CartList>? cartList;
  CartData({
    required this.cartList,
  });
  CartData.fromJson(Map<String, dynamic> json) {
    if (json["cart_list"] != null) {
      cartList = <CartList>[];
      json["cart_list"].forEach((v) {
        cartList!.add(CartList.fromJson(v));
      });
    }
  }
}

class CartList {
  int? id;
  int? shopId;
  String? shopName;
  String? shopAddress;
  String? areaName;
  String? cityName;
  int? shopPincode;
  String? itemCount;
  int? totalAmount;

  CartList({
    required this.id,
    required this.shopId,
    required this.shopName,
    required this.shopAddress,
    required this.areaName,
    required this.cityName,
    required this.shopPincode,
    required this.itemCount,
    required this.totalAmount,
  });

  CartList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    shopId = json["shop_id"];
    shopName = json["shop_name"];
    shopAddress = json["shop_address"];
    areaName = json["area_name"];
    cityName = json["city_name"];
    shopPincode = json["shop_pincode"];
    itemCount = json["item_count"];
    totalAmount = json["total_amount"];
  }
}
