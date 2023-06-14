class CouponCodeExistsRequestModel {
  String? couponCode;
  String? couponId;

  CouponCodeExistsRequestModel({this.couponCode, this.couponId});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["coupon_code"] = couponCode;
    data["coupon_id"] = couponId;
    return data;
  }
}

///////////////Response Model////////////////
class CouponCodeExistsResModel {
  int? status;
  String? message;

  CouponCodeExistsResModel({
    required this.status,
    required this.message,
  });

  CouponCodeExistsResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
