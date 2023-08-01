// class CustomerListModel {
//   int? status;
//   String? message;
// CustomerListData? data;

// CustomerListModel({
//   required this.status,
//   required this.message,
//   required this.data,
// });

// CustomerListModel.fromJson(Map<String, dynamic> json) {
//   status = json["status"];
//   message = json["message"];
//   data =
//       json['data'] != null ? CustomerListData.fromJson(json['data']) : null;
// }
// }

// class CustomerListData {
//   List<CustomerDetail>? customerDetails;

//   CustomerListData({
//     required this.customerDetails,
//   });

// CustomerListData.fromJson(Map<String, dynamic> json) {
//   if (json["customer_details"] != null) {
//     customerDetails = <CustomerDetail>[];
//     json["customer_details"].forEach((v) {
//       customerDetails!.add(CustomerDetail.fromJson(v));
//     });
//   }
// }
// }

// class CustomerDetail {
//   int? id;
//   String? customerName;
//   String? customerProfileImagePath;
//   String? customerProfileImageName;
//   String? areaName;
//   String? cityName;
//   String? mobileNumber;
//   String? isShopFavourite;

//   CustomerDetail({
//     required this.id,
//     required this.customerName,
//     required this.customerProfileImagePath,
//     required this.customerProfileImageName,
//     required this.areaName,
//     required this.cityName,
//     required this.mobileNumber,
//     required this.isShopFavourite,
//   });

// CustomerDetail.fromJson(Map<String, dynamic> json) {
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
class CustomerListModel {
  int? status;
  String? message;
  CustomerListData? customerListData;

  CustomerListModel({
    required this.status,
    required this.message,
    required this.customerListData,
  });

  CustomerListModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    customerListData =
        json['data'] != null ? CustomerListData.fromJson(json['data']) : null;
  }
}

class CustomerListData {
  List<AllCustomerListElement>? allCustomerList;
  List<AllCustomerListElement>? favouriteToShopsList;
  List<AllCustomerListElement>? orderedButNotFavouriteList;

  CustomerListData({
    required this.allCustomerList,
    required this.favouriteToShopsList,
    required this.orderedButNotFavouriteList,
  });
  CustomerListData.fromJson(Map<String, dynamic> json) {
    if (json["all_customer_list"] != null) {
      allCustomerList = <AllCustomerListElement>[];
      json["all_customer_list"].forEach((v) {
        allCustomerList!.add(AllCustomerListElement.fromJson(v));
      });
    }
    if (json["favourite_to_shops_list"] != null) {
      favouriteToShopsList = <AllCustomerListElement>[];
      json["favourite_to_shops_list"].forEach((v) {
        favouriteToShopsList!.add(AllCustomerListElement.fromJson(v));
      });
    }
    if (json["ordered_but_not_favourite_list"] != null) {
      orderedButNotFavouriteList = <AllCustomerListElement>[];
      json["ordered_but_not_favourite_list"].forEach((v) {
        orderedButNotFavouriteList!.add(AllCustomerListElement.fromJson(v));
      });
    }
  }
}

class AllCustomerListElement {
  int? id;
  String? customerName;
  String? customerProfileImagePath;
  String? customerProfileImageName;
  String? areaName;
  String? cityName;
  String? mobileNumber;
  String? createdAt;
  String? isShopFavourite;
  String? orderCount;

  AllCustomerListElement({
    required this.id,
    required this.customerName,
    required this.customerProfileImagePath,
    required this.customerProfileImageName,
    required this.areaName,
    required this.cityName,
    required this.mobileNumber,
    required this.createdAt,
    required this.isShopFavourite,
    required this.orderCount,
  });
  AllCustomerListElement.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    customerName = json["customer_name"];
    customerProfileImagePath = json["customer_profile_image_path"];
    customerProfileImageName = json["customer_profile_image_name"];
    areaName = json["area_name"];
    cityName = json["city_name"];
    mobileNumber = json["mobile_number"];
    createdAt = json["created_at"];
    isShopFavourite = json["is_shop_favourite"];
    orderCount = json["orders_count"];
  }
}
