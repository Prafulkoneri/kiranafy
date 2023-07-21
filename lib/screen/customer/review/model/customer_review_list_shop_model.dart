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
  ShopReviewlistrData? reviewlisteData;

  CustomerGetShopReviewListResponseModel({
    required this.status,
    required this.message,
    required this.reviewlisteData,
  });
  CustomerGetShopReviewListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    reviewlisteData = json['data'] != null
        ? ShopReviewlistrData.fromJson(json['data'])
        : null;
  }
}

class ShopReviewlistrData {
  List<ReviewList>? reviewList;
  ShopDetails? shopDetails;

  ShopReviewlistrData({
    required this.reviewList,
    required this.shopDetails,
  });
  ShopReviewlistrData.fromJson(Map<String, dynamic> json) {
    if (json["review_list"] != null) {
      reviewList = <ReviewList>[];
      json["review_list"].forEach((v) {
        reviewList!.add(ReviewList.fromJson(v));
      });
    }
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


