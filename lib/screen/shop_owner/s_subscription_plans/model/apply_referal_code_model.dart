class ApplyReferalCodeReqModel {
  String? referalCode;

  ApplyReferalCodeReqModel({
    this.referalCode,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["referral_code"] = referalCode;
    return data;
  }
}

////////////////////
class ApplyRefResmodel {
  int? status;
  String? discountPercentage;
  String? message;

  ApplyRefResmodel({
    required this.status,
    required this.discountPercentage,
    required this.message,
  });
  ApplyRefResmodel.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    discountPercentage = json["discount_percentage"];
    status = json["status"];
  }
}
