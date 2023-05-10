class CheckMobNoExistReqModel{
  String ? countryCode;
  String ? mobileNo;
  CheckMobNoExistReqModel({
    this.countryCode,
    this.mobileNo,
});
  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = {};
    data["mobile_number"]=mobileNo;
    data["country_code"]=countryCode;
    return data;
  }
}
class CheckMobNoExistResModel{
  int ? status;
  String ? message;
  CheckMobNoExistResModel({
    this.status,
    this.message,
  });
  CheckMobNoExistResModel.fromJson(Map<String, dynamic> json){
    status = json["status"];
    message = json["message"];
  }
}