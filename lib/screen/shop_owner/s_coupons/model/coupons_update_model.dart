class UpdateEditCouponReqModel {
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
  String? productId;
  String? productType;


  UpdateEditCouponReqModel({
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
    this.productId,
    this.productType,
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
    data["shop_owner_product_id"] = productId;
    data["shop_owner_product_type"] = productType;
    return data;
  }
}

////////ResPonse Model/////////////////
class UpdateEditCouponsResModel {
  int? status;
  String? message;

  UpdateEditCouponsResModel({
    required this.status,
    required this.message,
  });
  UpdateEditCouponsResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
