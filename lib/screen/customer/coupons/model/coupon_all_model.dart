class CustomerCouponListModel {
  int? status;
  String? message;
  AllCouponListData? allCouponlistdata;

  CustomerCouponListModel({
    required this.status,
    required this.message,
    required this.allCouponlistdata,
  });
  CustomerCouponListModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    allCouponlistdata = json['data'] != null
        ? AllCouponListData.fromJson(json['data'])
        : null;
  }

}

class AllCouponListData {
  List<ShopEnquiriesDetail>? shopEnquiriesDetails;

  AllCouponListData({
    required this.shopEnquiriesDetails,
  });
  AllCouponListData.fromJson(Map<String, dynamic> json) {
    if (json["shop_enquiries_details"] != null) {
      shopEnquiriesDetails = <ShopEnquiriesDetail>[];
      json["shop_enquiries_details"].forEach((v) {
        shopEnquiriesDetails!.add(ShopEnquiriesDetail.fromJson(v));
      });
    }


  }

}

class ShopEnquiriesDetail {
  int? id;
  String? shopId;
  String? shopName;
  String? termsCondition;
  String? couponToDate;
  int? couponDiscountPercentage;
  String? couponDiscountMaxAmount;
  String? couponCode;
  String? createdAt;

  ShopEnquiriesDetail({
    required this.id,
    required this.shopId,
    required this.shopName,
    required this.termsCondition,
    required this.couponToDate,
    required this.couponDiscountPercentage,
    required this.couponDiscountMaxAmount,
    required this.couponCode,
    required this.createdAt,
  });
  ShopEnquiriesDetail.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    shopId = json["shop_id"];
    shopName = json["shop_name"];
    termsCondition = json["coupon_terms_and_conditions"];
    couponToDate = json["coupon_to_date"];
    couponDiscountPercentage = json["coupon_discount_percentage"];
    couponDiscountMaxAmount = json["coupon_discount_max_amount"];
    couponCode = json["coupon_code"];
    createdAt = json["created_at"];
  }
}
