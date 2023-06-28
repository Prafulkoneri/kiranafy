
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
  LocationData ? data;
  SetPincodeResModel({
   this.message,
   this.status,
    this.data,
});
  SetPincodeResModel.fromJson(Map<String,dynamic>json){
    status=json["status"];
    message=json["message"];
    data = json['data'] != null ? LocationData.fromJson(json['data']) : null;
  }
}

class LocationData{
  String? areaName;
  String ? cityName;
  String ? pincode;
  LocationData({
    this.pincode,
    this.areaName,
    this.cityName
});
  LocationData.fromJson(Map<String,dynamic>json){
    areaName=json["area_name"];
    cityName=json["city_name"];
    pincode=json["pincode"];
  }
}