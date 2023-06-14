class ShopCustomerDetailReqModel {
  String? customerId;

  ShopCustomerDetailReqModel({
    this.customerId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["customer_id"] = customerId;
    return data;
  }
}

//////Res//
class CustomerDetailResModel {
  int? status;
  String? message;
  ShopCustomerDetail? data;

  CustomerDetailResModel({
    required this.status,
    required this.message,
    required this.data,
  });

  CustomerDetailResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data =
        json['data'] != null ? ShopCustomerDetail.fromJson(json['data']) : null;
  }
}

class ShopCustomerDetail {
  int? id;
  String? customerName;
  String? customerProfileImagePath;
  String? customerProfileImageName;
  String? areaName;
  String? cityName;
  String? mobileNumber;
  String? isShopFavourite;

  ShopCustomerDetail({
    required this.id,
    required this.customerName,
    required this.customerProfileImagePath,
    required this.customerProfileImageName,
    required this.areaName,
    required this.cityName,
    required this.mobileNumber,
    required this.isShopFavourite,
  });

  ShopCustomerDetail.fromJson(Map<String, dynamic> json) {
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
