//////////REQUEST MODDEL///////////////

class CustomerApplyCouponsRequestModel {
  String? cartId;
  String? shopId;
  String? couponId;
  String? subTotal;
  String? couponDiscount;
  String? totalDiscount;
  String? deliveryCharges;
  String? productTotalDiscount;
  String? total;

  CustomerApplyCouponsRequestModel(
      {this.cartId,
      this.shopId,
      this.couponId,
      this.subTotal,
      this.couponDiscount,
      this.totalDiscount,
      this.deliveryCharges,
      this.productTotalDiscount,
      this.total});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["cart_id"] = cartId;
    data["shop_id"] = shopId;
    data["coupon_id"] = couponId;
    data["sub_total"] = subTotal;
    data["coupon_discount"] = couponDiscount;
    data["total_discount"] = totalDiscount;
    data["delivery_charges"] = deliveryCharges;
    data["product_total_discount"] = productTotalDiscount;
    data["total"] = total;
    return data;
  }
}

/////////RESPONSE MODEL???????
class CustomerApplyCouponsResModel {
  int? status;
  String? message;
  ApplyCouponData? applyCouponData;

  CustomerApplyCouponsResModel({
    required this.status,
    required this.message,
    required this.applyCouponData,
  });
  CustomerApplyCouponsResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    applyCouponData =
        json['data'] != null ? ApplyCouponData.fromJson(json['data']) : null;
  }
}

class ApplyCouponData {
  String? couponCode;
  String? couponDiscount;
  String? subTotal;
  String? deliveryCharges;
  String? total;
  String? totalDiscount;

  ApplyCouponData({
    required this.couponCode,
    required this.couponDiscount,
    required this.subTotal,
    required this.deliveryCharges,
    required this.total,
    required this.totalDiscount,
  });
  ApplyCouponData.fromJson(Map<String, dynamic> json) {
    couponCode = json["coupon_code"];
    couponDiscount = json["coupon_discount"];
    subTotal = json["sub_total"];
    deliveryCharges = json["delivery_charges"];
    total = json["total"];
    totalDiscount = json["total_discount"];
  }
}
