///Request Model

class UpdateProfileDetailReqModel {
  String? customerName;
  String? customerEmail;
  String? customerCountryCode;

  String? customerMobileNumber;
  String? customerAlternateCountryCode;
  String? customerAlternateMobileNumber;
  String? customerGender;
  String? customerDateOfBirth;
  String? customerCountryId;
  String? customerStateId;
  String? customerCityId;
  String? customerAreaId;
  String? customerPincode;
  String? customerAddress;
  String? customerProfileImagePath;

  UpdateProfileDetailReqModel({
    required this.customerName,
    required this.customerEmail,
    required this.customerCountryCode,
    required this.customerMobileNumber,
    required this.customerAlternateCountryCode,
    required this.customerAlternateMobileNumber,
    required this.customerGender,
    required this.customerDateOfBirth,
    required this.customerCountryId,
    required this.customerCityId,
    required this.customerStateId,
    required this.customerAreaId,
    required this.customerPincode,
    required this.customerAddress,
     this.customerProfileImagePath,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["customer_name"] = customerName;
    data["customer_email"] = customerEmail;
    data["customer_country_code"] = customerCountryCode;

    // data["customer_profile_image_path"] = customerProfileImagePath;
    data["customer_address"] = customerAddress;
    data["customer_pincode"] = customerPincode;
    data["customer_area_id"] = customerAreaId;
    data["customer_state_id"] = customerStateId;
    data["customer_country_id"] = customerCountryId;
    data["customer_date_of_birth"] = customerDateOfBirth;
    data["customer_gender"] = customerGender;
    data["customer_alternate_mobile_number"] = customerAlternateMobileNumber;
    data["customer_alternate_country_code"] = customerAlternateCountryCode;
    data["customer_mobile_number"] = customerMobileNumber;
    data["customer_city_id"] = customerCityId;

    return data;
  }
}

/////ResPonse Model
class UpdateProfileDetailResModel {
  int? status;
  String? message;

  UpdateProfileDetailResModel({
    required this.status,
    required this.message,
  });

  UpdateProfileDetailResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
