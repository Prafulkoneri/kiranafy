import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';

class CustomerShopReviewListRequestModel {
  String? shopId;

  CustomerShopReviewListRequestModel({
    this.shopId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["shop_id"] = shopId;

    return data;
  }
}
///////////////////////////////////////////////////////////////

class CustomerGetShopReviewListResponseModel {
  int? status;
  String? message;
  ShopReviewlistData? reviewlistData;

  CustomerGetShopReviewListResponseModel({
    required this.status,
    required this.message,
    required this.reviewlistData,
  });
  CustomerGetShopReviewListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    reviewlistData =
        json['data'] != null ? ShopReviewlistData.fromJson(json['data']) : null;
  }
}

class ShopReviewlistData {
  List<ReviewList>? reviewList;
  ShopDetails? shopDetails;

  ShopReviewlistData({
    required this.reviewList,
    required this.shopDetails,
  });
  ShopReviewlistData.fromJson(Map<String, dynamic> json) {
    if (json["review_list"] != null) {
      reviewList = <ReviewList>[];
      json["review_list"].forEach((v) {
        reviewList!.add(ReviewList.fromJson(v));
      });
    }
    shopDetails = json['shop_details'] != null
        ? ShopDetails.fromJson(json['shop_details'])
        : null;
  }
}

class ReviewList {
  int? id;
  String? customerProfileImagePath;
  String? customerProfileImageName;
  String? customerName;
  String? cityName;
  String? stateName;
  String? review;
  int? ratings;
  String? createdAt;
  String ? orderUniqueId;
  int ?orderId;

  ReviewList({
    required this.id,
    required this.customerProfileImagePath,
    required this.customerProfileImageName,
    required this.customerName,
    required this.cityName,
    required this.stateName,
    required this.review,
    required this.ratings,
    required this.createdAt,
    required this.orderId,
    required this.orderUniqueId,
  });
  ReviewList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    customerProfileImagePath = json["customer_profile_image_path"];
    customerProfileImageName = json["customer_profile_image_name"];
    customerName = json["customer_name"];
    cityName = json["city_name"];
    stateName = json["state_name"];
    review = json["review"];
    ratings = json["ratings"];
    createdAt = json["created_at"];
    orderUniqueId = json["order_unique_id"];
    orderId = json["order_id"];
  }
}

// class ShopDetails {
//     String id;
//     String shopName;
//     String areaName;
//     String cityName;
//     String shopAddress;
//     int shopPincode;
//     String shopOwnerSupportNumber;
//     String isFavourite;

//     ShopDetails({
//         required this.id,
//         required this.shopName,
//         required this.areaName,
//         required this.cityName,
//         required this.shopAddress,
//         required this.shopPincode,
//         required this.shopOwnerSupportNumber,
//         required this.isFavourite,
//     });

// }


