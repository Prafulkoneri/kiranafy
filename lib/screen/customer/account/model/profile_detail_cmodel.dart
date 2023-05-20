class CustomerProfileDetailsRes {
  int? status;
  String? message;
  Data? data;

  CustomerProfileDetailsRes({
    required this.status,
    required this.message,
    required this.data,
  });
  CustomerProfileDetailsRes.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];

    //array Shop Details

    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? customerName;
  String? customerEmail;
  String? customerCountryCode;
  int? customerMobileNumber;
  String? customerProfileImagePath;
  String? customerProfileImageName;

  Data({
    required this.id,
    required this.customerName,
    this.customerEmail,
    required this.customerCountryCode,
    required this.customerMobileNumber,
    required this.customerProfileImagePath,
    this.customerProfileImageName,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    customerName = json["customer_name"];
    customerEmail = json["customer_email"];
    customerCountryCode = json["customer_country_code"];
    customerEmail = json["customer_email"];
    customerMobileNumber = json["customer_mobile_number"];
    customerProfileImageName = json["customer_profile_image_name"];
    customerProfileImagePath = json["customer_profile_image_path"];
  }
}
