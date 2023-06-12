class DeliveryAddressListModel {
  int? status;
  String? message;
  List<DeliveryAddressList>? data;

  DeliveryAddressListModel({
    required this.status,
    required this.message,
    required this.data,
  });
  DeliveryAddressListModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];

    if (json["data"] != null) {
      data = <DeliveryAddressList>[];
      json["data"].forEach((v) {
        data!.add(DeliveryAddressList.fromJson(v));
      });
    }
  }
}

class DeliveryAddressList {
  int? id;
  String? customerName;
  String? deliveryCountryCode;
  int? deliveryMobileNumber;
  String? deliveryAddressType;
  String? deliveryAddressIsDefault;
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
  String? status;
  String? countryName;
  String? stateName;
  String? cityName;
  String? areaName;
  String? address1;
  String? address2;

  DeliveryAddressList({
    required this.id,
    required this.customerName,
    required this.deliveryCountryCode,
    required this.deliveryMobileNumber,
    required this.deliveryAddressType,
    required this.deliveryAddressIsDefault,
    required this.deliveryCountryId,
    required this.deliveryStateId,
    required this.deliveryCityId,
    required this.deliveryAreaId,
    required this.deliveryPincode,
    required this.deliveryAppartmentName,
    required this.deliveryHouseNo,
    required this.deliveryStreet,
    required this.deliveryArea,
    required this.deliveryLandmark,
    required this.status,
    required this.countryName,
    required this.stateName,
    required this.cityName,
    required this.areaName,
    required this.address1,
    required this.address2,
  });

  DeliveryAddressList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    customerName = json["customer_name"];
    deliveryCountryCode = json["delivery_country_code"];
    deliveryMobileNumber = json["delivery_mobile_number"];
    deliveryAddressType = json["delivery_address_type"];
    deliveryAddressIsDefault = json["delivery_address_is_default"];
    deliveryCountryId = json["delivery_country_id"];
    deliveryStateId = json["delivery_state_id"];
    deliveryCityId = json["delivery_city_id"];
    deliveryAreaId = json["delivery_area_id"];
    deliveryPincode = json["delivery_pincode"];
    deliveryAppartmentName = json["delivery_appartment_name"];
    deliveryHouseNo = json["delivery_house_no"];
    deliveryStreet = json["delivery_street"];
    deliveryArea = json["delivery_area"];
    deliveryLandmark = json["delivery_landmark"];
    status = json["status"];
    countryName = json["country_name"];
    stateName = json["state_name"];
    cityName = json["city_name"];
    areaName = json["area_name"];
    address1 = json["address_1"];
    address2 = json["address_2"];
  }
}
