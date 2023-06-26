
class SetPincodeReqModel {
  String? currentLocationPincode;

  SetPincodeReqModel({this.currentLocationPincode});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["customer_current_location_pincode"] = currentLocationPincode;
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