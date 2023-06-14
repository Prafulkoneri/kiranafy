///Request MOdel///////
class ViewCouponsDetailRequestModel {
  String? couponId;

  ViewCouponsDetailRequestModel({
    this.couponId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["coupon_id"] = couponId;
    return data;
  }
}

///////////RESPONSE MODEL////////////

class ViewCoupnDetailResModel {
  int? status;
  String? message;
  CouponViewData? data;
  String? shopName;

  ViewCoupnDetailResModel({
    required this.status,
    required this.message,
    required this.data,
    required this.shopName,
  });

  ViewCoupnDetailResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json['data'] != null ? CouponViewData.fromJson(json['data']) : null;
    shopName = json["shop_name"];
  }
}

class CouponViewData {
  int? id;
  String? couponFromDate;
  String? couponToDate;
  String? couponDiscountPercentage;
  int? couponMinimumOrderAmount;
  int? couponDiscountMaxAmount;
  String? couponCode;
  String? couponType;
  String? couponTermsAndConditions;
  String? status;

  CouponViewData({
    required this.id,
    required this.couponFromDate,
    required this.couponToDate,
    required this.couponDiscountPercentage,
    required this.couponMinimumOrderAmount,
    required this.couponDiscountMaxAmount,
    required this.couponCode,
    required this.couponType,
    required this.couponTermsAndConditions,
    required this.status,
  });

  CouponViewData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    couponFromDate = json["coupon_from_date"];
    couponToDate = json["coupon_to_date"];
    couponDiscountPercentage = json["coupon_discount_percentage"];
    couponMinimumOrderAmount = json["coupon_minimum_order_amount"];
    couponDiscountMaxAmount = json["coupon_discount_max_amount"];
    couponCode = json["coupon_code"];
    couponType = json["coupon_type"];
    couponTermsAndConditions = json["coupon_terms_and_conditions"];
    status = json["status"];
  }
}
