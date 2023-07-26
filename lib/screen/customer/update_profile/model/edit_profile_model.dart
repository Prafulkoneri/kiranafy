import 'package:local_supper_market/screen/shop_owner/s_auth/model/area_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/city_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/country_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/state_model.dart';

class CustomerEditProfileDetails {
  int? status;
  String? message;
  CustomerProfileDetails? customerProfileDetails;
  List<CountryData> ? countries;
  List<StateData> ? state;
  List<CityData> ? city;
  List<AreaData> ? area;
  List ? pincode;

  CustomerEditProfileDetails({
    required this.status,
    required this.message,
    required this.customerProfileDetails,
  });

  CustomerEditProfileDetails.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];

    customerProfileDetails = json['customer_profile_details'] != null
        ? CustomerProfileDetails.fromJson(json['customer_profile_details'])
        : null;
    if (json["countries"] != null) {
      countries = <CountryData>[];
      json["countries"].forEach((v) {
        countries!.add(CountryData.fromJson(v));
      });
    }
    if (json["states"] != null) {
      state = <StateData>[];
      json["states"].forEach((v) {
        state!.add(StateData.fromJson(v));
      });
    }
    if (json["cities"] != null) {
      city = <CityData>[];
      json["cities"].forEach((v) {
        city!.add(CityData.fromJson(v));
      });
    }
    if (json["areas"] != null) {
      area = <AreaData>[];
      json["areas"].forEach((v) {
        area!.add(AreaData.fromJson(v));
      });
    }
    if (json["pincodes"] != null) {
      pincode = [];
      json["pincodes"].forEach((v) {
        pincode!.add(v);
      });
    }
  }
}

class CustomerProfileDetails {
  int? id;
  String? customerName;
  String? customerEmail;
  String? customerCountryCode;
  int? customerMobileNumber;
  String? customerAlternateCountryCode;
  int? customerAlternateMobileNumber;
  String? customerGender;
  String? customerDateOfBirth;
  int? customerCountryId;
  String? countryName;
  int? customerStateId;
  String? stateName;
  int? customerCityId;
  String? cityName;
  String? areaName;
  int? customerAreaId;
  int? customerPincode;
  String? customerAddress;
  String? customerProfileImagePath;
  String? customerProfileImageName;

  CustomerProfileDetails({
    required this.id,
    required this.customerName,
    required this.customerEmail,
    required this.customerCountryCode,
    required this.customerMobileNumber,
    required this.customerAlternateCountryCode,
    required this.customerAlternateMobileNumber,
    required this.customerGender,
    required this.customerDateOfBirth,
    required this.customerCountryId,
    required this.countryName,
    required this.customerStateId,
    required this.stateName,
    required this.customerCityId,
    required this.cityName,
    required this.areaName,
    required this.customerAreaId,
    required this.customerPincode,
    required this.customerAddress,
    required this.customerProfileImagePath,
    required this.customerProfileImageName,
  });
  CustomerProfileDetails.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    customerName = json["customer_name"];
    customerEmail = json["customer_email"];
    customerCountryCode = json["customer_country_code"];
    customerEmail = json["customer_email"];
    customerMobileNumber = json["customer_mobile_number"];
    customerAlternateMobileNumber = json["customer_alternate_mobile_number"];
    customerGender = json["customer_gender"];
    customerDateOfBirth = json["customer_date_of_birth"];
    customerCountryId = json["customer_country_id"];
    countryName = json["country_name"];
    customerStateId = json["customer_state_id"];
    stateName = json["state_name"];
    customerCityId = json["customer_city_id"];
    cityName = json["city_name"];
    areaName = json["area_name"];
    customerAreaId = json["customer_area_id"];
    customerPincode = json["customer_pincode"];
    customerAddress = json["customer_address"];
    customerProfileImageName = json["customer_profile_image_name"];
    customerProfileImagePath = json["customer_profile_image_path"];
  }
}
