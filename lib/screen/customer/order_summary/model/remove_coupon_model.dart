//////////REQUEST MODDEL///////////////

class CustomerRemoveCouponsRequestModel {
  String? cartId;
  String? shopId;

  CustomerRemoveCouponsRequestModel(
      {this.cartId,
        this.shopId,
      });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["cart_id"] = cartId;
    data["shop_id"] = shopId;
    return data;
  }
}

/////////RESPONSE MODEL???????
class CustomerRemoveCouponsResModel {
  int? status;
  String? message;
  Data? data;

  CustomerRemoveCouponsResModel({
    required this.status,
    required this.message,
    required this.data,
  });
  CustomerRemoveCouponsResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data =
    json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data{
  RemoveCouponData? removeCouponData;
  Data({
    this.removeCouponData,
});
  Data.fromJson(Map<String,dynamic>json){
    removeCouponData =
    json['order_final_totals'] != null ? RemoveCouponData.fromJson(json['order_final_totals']) : null;
  }
}

class RemoveCouponData {
  int? couponDiscount;
  int? subTotal;
  int? deliveryCharges;
  int? total;
  int? totalDiscount;

  RemoveCouponData({
    required this.couponDiscount,
    required this.subTotal,
    required this.deliveryCharges,
    required this.total,
    required this.totalDiscount,
  });
  RemoveCouponData.fromJson(Map<String, dynamic> json) {
    couponDiscount = json["coupon_discount"];
    subTotal = json["sub_total"];
    deliveryCharges = json["delivery_charges"];
    total = json["total"];
    totalDiscount = json["total_discount"];
  }
}
