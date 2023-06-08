////////Request Model//////////////
class AddAddressRequestModel {
  String? customerName; //
  String? deliveryCountryCode;
  String? deliveryMobileNumber; //
  String? deliveryAddressType; //
  String? deliveryCountryId;
  String? deliveryStateId;
  String? deliveryCityId;
  String? deliveryAreaId;
  String? deliveryPincode;
  String? deliveryAppartmentName;
  String? deliveryHouseNo;
  String? deliveryStreet;
  String? deliveryArea;
  String? deliveryLandmark;

  AddAddressRequestModel({
    required this.customerName,
    required this.deliveryCountryCode,
    required this.deliveryMobileNumber,
    required this.deliveryAddressType,
    required this.deliveryCityId,
    required this.deliveryCountryId,
    required this.deliveryStateId,
    required this.deliveryAreaId,
    required this.deliveryPincode,
    required this.deliveryAppartmentName,
    required this.deliveryHouseNo,
    required this.deliveryStreet,
    required this.deliveryArea,
    required this.deliveryLandmark,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["customer_name"] = customerName;
    data["delivery_country_code"] = deliveryCountryCode;
    data["delivery_mobile_number"] = deliveryMobileNumber;
    data["delivery_address_type"] = deliveryAddressType;
    data["delivery_city_id"] = deliveryCityId;
    data["delivery_country_id"] = deliveryCountryId;
    data["delivery_state_id"] = deliveryStateId;
    data["delivery_area_id"] = deliveryAreaId;
    data["delivery_pincode"] = deliveryPincode;
    data["delivery_appartment_name"] = deliveryAppartmentName;
    data["delivery_house_no"] = deliveryHouseNo;
    data["delivery_street"] = deliveryStreet;
    data["delivery_area"] = deliveryArea;
    data["delivery_landmark"] = deliveryLandmark;

    return data;
  }
}

/////Response Model///
class AddAddressResponseModel {
  int? status;
  String? message;

  AddAddressResponseModel({
    required this.status,
    required this.message,
  });
  AddAddressResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
