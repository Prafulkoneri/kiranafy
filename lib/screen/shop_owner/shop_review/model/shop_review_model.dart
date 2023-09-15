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
