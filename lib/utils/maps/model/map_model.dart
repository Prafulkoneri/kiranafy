class MapRequestModel {
  String? customerCurrentLocation;

  MapRequestModel({
    this.customerCurrentLocation,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["customer_current_location_pincode"] = customerCurrentLocation;

    return data;
  }
}

//////////////////ResPonse Model/////////////
class MapResponseModel {
  int? status;
  String? message;
  MapResponseModel({
    required this.status,
    required this.message,
  });
  MapResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
