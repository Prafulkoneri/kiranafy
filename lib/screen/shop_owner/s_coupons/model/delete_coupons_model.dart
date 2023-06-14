class DeleteCouponsReqModel {
  String? couponId;

  DeleteCouponsReqModel({
    this.couponId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["coupon_id"] = couponId;
    return data;
  }
}

////////////RES//////////
class DeleteCouponsResModel {
  int? status;
  String? message;

  DeleteCouponsResModel({
    required this.status,
    required this.message,
  });

  DeleteCouponsResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
