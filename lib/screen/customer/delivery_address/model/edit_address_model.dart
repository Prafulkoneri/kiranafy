import 'package:local_supper_market/screen/shop_owner/s_auth/model/area_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/city_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/country_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/state_model.dart';

///////////Request model////////////

class EditDeliveryAddressRequestModel {
  String? deliveryAddressId;

  EditDeliveryAddressRequestModel({
    required this.deliveryAddressId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["delivery_address_id"] = deliveryAddressId;
    return data;
  }
}

////////////Res Model//////////
class EditDeliveryAddressResponseModel {
  int ? status;
  String ? message;
  DeliveryAddressDetails ? deliveryAddressDetails;
  List<CountryData> ? countries;
  List<StateData> ? states;
  List<CityData> ? cities;
  List<AreaData> ? areas;
  List<String> ? pincodes;

  EditDeliveryAddressResponseModel({
    required this.status,
    required this.message,
    required this.deliveryAddressDetails,
    required this.countries,
    required this.states,
    required this.cities,
    required this.areas,
    required this.pincodes,
  });
  EditDeliveryAddressResponseModel.fromJson(Map<String,dynamic>json){
    status=json["status"];
    message=json["message"];
    deliveryAddressDetails = json['delivery_address_details'] != null ? DeliveryAddressDetails.fromJson(json['delivery_address_details']) : null;
    if (json["countries"] != null) {
      countries = <CountryData>[];
      json["countries"].forEach((v) {
        countries!.add(CountryData.fromJson(v));
      });
    }
    if (json["states"] != null) {
      states = <StateData>[];
      json["states"].forEach((v) {
        states!.add(StateData.fromJson(v));
      });
    }
    if (json["cities"] != null) {
      cities = <CityData>[];
      json["cities"].forEach((v) {
        cities!.add(CityData.fromJson(v));
      });
    }
    if (json["areas"] != null) {
      areas = <AreaData>[];
      json["areas"].forEach((v) {
        areas!.add(AreaData.fromJson(v));
      });
    }
    if (json["pincodes"] != null) {
      pincodes = [];
      json["pincodes"].forEach((v) {
        pincodes!.add(v);
      });
    }
  }
}

class DeliveryAddressDetails {
  int ? id;
  int ? customerId;
  String ? customerName;
  String ? deliveryCountryCode;
  int ? deliveryMobileNumber;
  String ? deliveryAddressType;
  String ? deliveryAddressIsDefault;
  int ? deliveryCountryId;
  int ? deliveryStateId;
  int ? deliveryCityId;
  int ? deliveryAreaId;
  int ? deliveryPincode;
  String ? deliveryAppartmentName;
  String ? deliveryHouseNo;
  String ? deliveryStreet;
  String ? deliveryArea;
  String ? deliveryLandmark;


  DeliveryAddressDetails({
    required this.id,
    required this.customerId,
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
  });
  DeliveryAddressDetails.fromJson(Map<String,dynamic>json){
    id=json["id"];
    customerId=json["customer_id"];
    customerName=json["customer_name"];
    deliveryCountryCode=json["delivery_country_code"];
    deliveryMobileNumber=json["delivery_mobile_number"];
    deliveryAddressType=json["delivery_address_type"];
    deliveryAddressIsDefault=json["delivery_address_is_default"];
    deliveryCountryId=json["delivery_country_id"];
    deliveryStateId=json["delivery_state_id"];
    deliveryCityId=json["delivery_city_id"];
    deliveryAreaId=json["delivery_area_id"];
    deliveryPincode=json["delivery_pincode"];
    deliveryAppartmentName=json["delivery_appartment_name"];
    deliveryHouseNo=json["delivery_house_no"];
    deliveryStreet=json["delivery_street"];
    deliveryArea=json["delivery_area"];
    deliveryLandmark=json["delivery_landmark"];
  }

}



