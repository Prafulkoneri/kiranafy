import 'package:local_supper_market/screen/customer/review/model/customer_review_list_shop_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';

class ShopReviewListModel {
  int? status;
  String? message;
  Data? data;

  ShopReviewListModel({
    required this.status,
    required this.message,
    required this.data,
  });
  ShopReviewListModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<ReviewList>? reviewList;
  ShopDetails? shopDetails;

  Data({
    required this.reviewList,
    required this.shopDetails,
  });
  Data.fromJson(Map<String, dynamic> json) {
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

// class ReviewList {
//     int? id;
//     String customerProfileImagePath;
//     String customerProfileImageName;
//     String customerName;
//     String cityName;
//     String stateName;
//     String review;
//     int ratings;
//     String createdAt;

//     ReviewList({
//         required this.id,
//         required this.customerProfileImagePath,
//         required this.customerProfileImageName,
//         required this.customerName,
//         required this.cityName,
//         required this.stateName,
//         required this.review,
//         required this.ratings,
//         required this.createdAt,
//     });

// }
 
// class ShopDetails {
//     int id;
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
