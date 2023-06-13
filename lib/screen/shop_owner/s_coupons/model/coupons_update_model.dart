class UpdateCouponReqModel {
  String? couponId;
  String? couponFromDate;
  String? couponToDate;
  String? couponDiscountPercentage;
  String? couponMinimumOrderAmount;
  String? couponDiscountMaxAmount;
  String? couponCode;
  String? couponType;
  String? shopOwnerCategoryId;
  String? couponsTermsAndCondition;

  UpdateCouponReqModel({
    this.couponId,
    this.couponFromDate,
    this.couponToDate,
    this.couponDiscountPercentage,
    this.couponMinimumOrderAmount,
    this.couponDiscountMaxAmount,
    this.couponCode,
    this.couponType,
    this.shopOwnerCategoryId,
    this.couponsTermsAndCondition,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["coupon_id"] = couponId; //
    data["coupon_from_date"] = couponFromDate; //
    data["coupon_to_date"] = couponToDate; //
    data["coupon_discount_percentage"] = couponDiscountPercentage; //
    data["coupon_minimum_order_amount"] = couponMinimumOrderAmount; //
    data["coupon_discount_max_amount"] = couponDiscountMaxAmount; //
    data["coupon_code"] = couponCode; //
    data["coupon_type"] = couponType; //
    data["shop_owner_category_id"] = shopOwnerCategoryId; //
    data["coupon_terms_and_conditions"] = couponsTermsAndCondition; //
    return data;
  }
}

////////ResPonse Model/////////////////
class UpdateCouponsResModel {
  int? status;
  String? message;

  UpdateCouponsResModel({
    required this.status,
    required this.message,
  });
  UpdateCouponsResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
