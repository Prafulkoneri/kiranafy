class CustomerListModel {
  int? status;
  String? message;
  CustomerListData? data;

  CustomerListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  CustomerListModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data =
        json['data'] != null ? CustomerListData.fromJson(json['data']) : null;
  }
}

class CustomerListData {
  List<CustomerDetail>? customerDetails;

  CustomerListData({
    required this.customerDetails,
  });

  CustomerListData.fromJson(Map<String, dynamic> json) {
    if (json["customer_details"] != null) {
      customerDetails = <CustomerDetail>[];
      json["customer_details"].forEach((v) {
        customerDetails!.add(CustomerDetail.fromJson(v));
      });
    }
  }
}

class CustomerDetail {
  int? id;
  String? customerName;
  String? customerProfileImagePath;
  String? customerProfileImageName;
  String? areaName;
  String? cityName;
  String? mobileNumber;
  String? isShopFavourite;

  CustomerDetail({
    required this.id,
    required this.customerName,
    required this.customerProfileImagePath,
    required this.customerProfileImageName,
    required this.areaName,
    required this.cityName,
    required this.mobileNumber,
    required this.isShopFavourite,
  });

  CustomerDetail.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    customerName = json["customer_name"];
    customerProfileImagePath = json["customer_profile_image_path"];
    customerProfileImageName = json["customer_profile_image_name"];
    areaName = json["area_name"];
    cityName = json["city_name"];
    mobileNumber = json["mobile_number"];
    isShopFavourite = json["is_shop_favourite"];
  }
}
