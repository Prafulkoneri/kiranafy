class CouponsListModel {
  int? status;
  String? message;
  List<CouponListData>? data;

  CouponsListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  CouponsListModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    if (json["data"] != null) {
      data = <CouponListData>[];
      json["data"].forEach((v) {
        data!.add(CouponListData.fromJson(v));
      });
    }
  }
}

class CouponListData {
  int? id;
  String? couponToDate;
  String? couponDiscountPercentage;
  String? couponDiscountMaxAmount;
  String? couponCode;

  CouponListData({
    required this.id,
    required this.couponToDate,
    required this.couponDiscountPercentage,
    required this.couponDiscountMaxAmount,
    required this.couponCode,
  });

  CouponListData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    couponToDate = json["coupon_to_date"];
    couponDiscountPercentage = json["coupon_discount_percentage"];
    couponDiscountMaxAmount = json["coupon_discount_max_amount"];
    couponCode = json["coupon_code"];
  }
}
