///Req Model Update Delivery Address////
class UpdateDeliveryAddressReqModel {
  String? customerName;
  String? deliveryCountryCode;
  String? deliveryAddressType;
  int? deliveryMobileNumber;
  int? deliveryCountryId;
  int? deliveryStateId;
  int? deliveryCityId;
  int? deliveryAreaId;
  int? deliveryPincode;
  String? deliveryAppartmentName;
  String? deliveryHouseNo;
  String? deliveryStreet;
  String? deliveryArea;
  String? deliveryLandmark;
  int? deliveryAddressId;

  UpdateDeliveryAddressReqModel(
      {required this.customerName,
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
      required this.deliveryAddressId});

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
    data["delivery_address_id"] = deliveryAddressId;
    return data;
  }
}

//////////Res////////////
class UpdateDeliveryAddressResModel {
  int? status;
  String? message;

  UpdateDeliveryAddressResModel({
    required this.status,
    required this.message,
  });
  UpdateDeliveryAddressResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
