class ShopPCouponsReqModel {
  String? shopId;

  ShopPCouponsReqModel({this.shopId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["shop_id"] = shopId;
    return data;
  }
}

////////////////////////////////////////////////////////////
class ShopPCouponsResModel {
  int? status;
  String? message;
  SProfileCouponData? sprofilecoupondata;

  ShopPCouponsResModel({
    required this.status,
    required this.message,
    required this.sprofilecoupondata,
  });
  ShopPCouponsResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    sprofilecoupondata =
        json['data'] != null ? SProfileCouponData.fromJson(json['data']) : null;
  }
}

class SProfileCouponData {
  List<ShopCouponsList>? shopCouponsList;

  SProfileCouponData({
    required this.shopCouponsList,
  });
  SProfileCouponData.fromJson(Map<String, dynamic> json) {
    if (json["shop_coupons_list"] != null) {
      shopCouponsList = <ShopCouponsList>[];
      json["shop_coupons_list"].forEach((v) {
        shopCouponsList!.add(ShopCouponsList.fromJson(v));
      });
    }
  }
}

class ShopCouponsList {
  int? id;
  String? shopName;
  String? couponTermsAndConditions;
  String? couponToDate;
  int? couponDiscountPercentage;
  String? couponDiscountMaxAmount;
  String? couponCode;

  ShopCouponsList({
    required this.id,
    required this.shopName,
    required this.couponTermsAndConditions,
    required this.couponToDate,
    required this.couponDiscountPercentage,
    required this.couponDiscountMaxAmount,
    required this.couponCode,
  });
  ShopCouponsList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    shopName = json["shop_name"];
    couponTermsAndConditions = json["coupon_terms_and_conditions"];
    couponToDate = json["coupon_to_date"];
    couponDiscountPercentage = json["coupon_discount_percentage"];
    couponDiscountMaxAmount = json["coupon_discount_max_amount"];
    couponCode = json["coupon_code"];
  }
}
