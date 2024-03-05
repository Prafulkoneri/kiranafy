class CheckMobNoExistReqModel {
  String? countryCode;
  String? mobileNo;

  CheckMobNoExistReqModel({
    this.countryCode,
    this.mobileNo,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["mobile_number"] = mobileNo;
    data["country_code"] = countryCode;
    return data;
  }
}

class CheckMobNoExistResModel {
  int? status;
  String? message;
  String? kycUploaded;
  String? registrationCompleted;
  String? subscription;

  CheckMobNoExistResModel({
    this.status,
    this.message,
    this.kycUploaded,
    this.registrationCompleted,
    this.subscription,
  });

  CheckMobNoExistResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    kycUploaded = json["kyc_uploaded"];
    registrationCompleted = json["registration_completed"];
    subscription = json["subscription"];
  }
}
