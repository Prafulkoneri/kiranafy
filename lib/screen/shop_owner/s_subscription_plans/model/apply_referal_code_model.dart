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
  String? amount;
  String? message;

  ApplyRefResmodel({
    required this.status,
    required this.amount,
    required this.message,
  });
  ApplyRefResmodel.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    amount = json["amount"];
    status = json["status"];
  }
}
