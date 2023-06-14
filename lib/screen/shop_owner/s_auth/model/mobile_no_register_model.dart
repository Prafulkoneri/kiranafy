class MobNoRegisterReqModel {
  String? countryCode;
  String? mobileNo;

  MobNoRegisterReqModel({
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

class MobNoRegisterResModel {
  int? status;
  String? message;
  String? mobileNo;
  String? countryCode;

  MobNoRegisterResModel({
    this.status,
    this.message,
    this.mobileNo,
    this.countryCode,
  });

  MobNoRegisterResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    countryCode = json["country_code"];
    mobileNo = json["mobile_number"];
  }
}
