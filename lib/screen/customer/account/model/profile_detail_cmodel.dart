class CustomerProfileDetailsRes {
  int? status;
  String? message;
  CustomerData? data;

  CustomerProfileDetailsRes({
    required this.status,
    required this.message,
    required this.data,
  });
  CustomerProfileDetailsRes.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json['data'] != null ? CustomerData.fromJson(json['data']) : null;
  }
}

class CustomerData {
  int? id;
  String? customerName;
  String? customerEmail;
  String? customerCountryCode;
  int? customerMobileNumber;
  String? customerProfileImagePath;
  String? customerProfileImageName;

  CustomerData({
    required this.id,
    required this.customerName,
    this.customerEmail,
    required this.customerCountryCode,
    required this.customerMobileNumber,
    required this.customerProfileImagePath,
    this.customerProfileImageName,
  });

  CustomerData.fromJson(Map<String, dynamic> json) {
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
