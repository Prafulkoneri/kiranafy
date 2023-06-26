
class SetPincodeReqModel {
  String? lat;
  String? lng;

  SetPincodeReqModel({this.lat,this.lng});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["lat"] = lat;
    data["lng"] = lng;
    return data;
  }
}

class SetPincodeResModel{
  int ? status;
  String ? message;
  SetPincodeResModel({
   this.message,
   this.status,
});
  SetPincodeResModel.fromJson(Map<String,dynamic>json){
    status=json["status"];
    message=json["message"];
  }
}