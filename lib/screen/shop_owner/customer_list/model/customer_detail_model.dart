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
// class CustomerDetailResModel {
//   int? status;
//   String? message;
//   ShopCustomerDetail? shopCustomerDetailData;

//   CustomerDetailResModel({
//     required this.status,
//     required this.message,
//     required this.shopCustomerDetailData,
//   });

// CustomerDetailResModel.fromJson(Map<String, dynamic> json) {
//   status = json["status"];
//   message = json["message"];
//   shopCustomerDetailData =
//       json['data'] != null ? ShopCustomerDetail.fromJson(json['data']) : null;
// }
// }

// class ShopCustomerDetail {
//   int? id;
//   String? customerName;
//   String? customerProfileImagePath;
//   String? customerProfileImageName;
//   String? areaName;
//   String? cityName;
//   String? mobileNumber;
//   String? isShopFavourite;

//   ShopCustomerDetail({
//     required this.id,
//     required this.customerName,
//     required this.customerProfileImagePath,
//     required this.customerProfileImageName,
//     required this.areaName,
//     required this.cityName,
//     required this.mobileNumber,
//     required this.isShopFavourite,
//   });

// ShopCustomerDetail.fromJson(Map<String, dynamic> json) {
//   id = json["id"];
//   customerName = json["customer_name"];
//   customerProfileImagePath = json["customer_profile_image_path"];
//   customerProfileImageName = json["customer_profile_image_name"];
//   areaName = json["area_name"];
//   cityName = json["city_name"];
//   mobileNumber = json["mobile_number"];
//   isShopFavourite = json["is_shop_favourite"];
// }
// }
class CustomerDetailResModel {
  int? status;
  String? message;
  ShopCustomerDetail? shopCustomerDetailData;

  CustomerDetailResModel({
    required this.status,
    required this.message,
    required this.shopCustomerDetailData,
  });
  CustomerDetailResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    shopCustomerDetailData =
        json['data'] != null ? ShopCustomerDetail.fromJson(json['data']) : null;
  }
}

class ShopCustomerDetail {
  CustomerDetails? customerDetails;
  List<CustomerOrderDetail>? customerOrderDetails;

  ShopCustomerDetail({
    required this.customerDetails,
    required this.customerOrderDetails,
  });
  ShopCustomerDetail.fromJson(Map<String, dynamic> json) {
    customerDetails = json['customer_details'] != null
        ? CustomerDetails.fromJson(json['customer_details'])
        : null;

    if (json["customer_order_details"] != null) {
      customerOrderDetails = <CustomerOrderDetail>[];
      json["customer_order_details"].forEach((v) {
        customerOrderDetails!.add(CustomerOrderDetail.fromJson(v));
      });
    }
  }
}

class CustomerDetails {
  int? id;
  String? customerName;
  String? customerProfileImagePath;
  String? customerProfileImageName;
  String? areaName;
  String? cityName;
  String? mobileNumber;
  String? isShopFavourite;

  CustomerDetails({
    required this.id,
    required this.customerName,
    required this.customerProfileImagePath,
    required this.customerProfileImageName,
    required this.areaName,
    required this.cityName,
    required this.mobileNumber,
    required this.isShopFavourite,
  });
  CustomerDetails.fromJson(Map<String, dynamic> json) {
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

class CustomerOrderDetail {
  int? id;
  String? orderUniqueId;
  String? orderStatus;
  String? createdAt;
  String? totalAmount;
  String? totalItems;

  CustomerOrderDetail({
    required this.id,
    required this.orderUniqueId,
    required this.orderStatus,
    required this.createdAt,
    required this.totalAmount,
    required this.totalItems,
  });
  CustomerOrderDetail.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    orderUniqueId = json["order_unique_id"];
    orderStatus = json["order_status"];
    createdAt = json["created_at"];
    totalAmount = json["total_amount"];
    totalItems = json["total_items"];
  }
}
