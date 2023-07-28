
class ReviewListRequestModel {
  String? orderId;

  ReviewListRequestModel({
    this.orderId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["order_id"] = orderId;

    return data;
  }
}

///////////////////////////////////////////////////////////
// class ReviewListReponseModel {
//   int? status;
//   String? message;
//   List<ReviewlistData>? reviewlistdata;
//
//   ReviewListReponseModel({
//     required this.status,
//     required this.message,
//     required this.reviewlistdata,
//   });
//   ReviewListReponseModel.fromJson(Map<String, dynamic> json) {
//     status = json["status"];
//     message = json["message"];
//     if (json["data"] != null) {
//       reviewlistdata = <ReviewlistData>[];
//       json["data"].forEach((v) {
//         reviewlistdata!.add(ReviewlistData.fromJson(v));
//       });
//     }
//   }
//
// }
//
// class ReviewlistData {
//   int? id;
//   int? customerId;
//   int? orderId;
//   int? shopId;
//   String? review;
//   String? customerName;
//   int? ratings;
//   DateTime? createdAt;
//   String? customerProfileImagePath;
//   String? customerProfileImageName;
//
//   ReviewlistData({
//     required this.id,
//     required this.customerId,
//     required this.orderId,
//     required this.shopId,
//     required this.review,
//     required this.customerName,
//     required this.ratings,
//     required this.createdAt,
//     this.customerProfileImagePath,
//     this.customerProfileImageName,
//   });
//   ReviewlistData.fromJson(Map<String, dynamic> json) {
//     id = json["id"];
//     customerId = json["customer_id"];
//     orderId = json["order_id"];
//     shopId = json["shop_id"];
//     shopId = json["customer_name"];
//     ratings = json["ratings"];
//     review = json["review"];
//     createdAt = json["created_at"];
//     customerProfileImagePath = json["customer_profile_image_path"];
//     customerProfileImageName = json["customer_profile_image_name"];
//   }
// }

class ReviewListReponseModel {
  int? status;
  String? message;
  OReviewlistData? oreviewlistdata;

  ReviewListReponseModel({
    required this.status,
    required this.message,
    required this.oreviewlistdata,
  });
  ReviewListReponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    oreviewlistdata =
    json['data'] != null ? OReviewlistData.fromJson(json['data']) : null;
  }

}

class OReviewlistData {
  List<ReviewList>? reviewList;

  OReviewlistData({
    required this.reviewList,
  });
  OReviewlistData.fromJson(Map<String, dynamic> json) {

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
  String? review;
  int? ratings;
  String? createdAt;

  ReviewList({
    required this.id,
    required this.customerProfileImagePath,
    required this.customerProfileImageName,
    required this.customerName,
    required this.review,
    required this.ratings,
    required this.createdAt,
  });
  ReviewList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    customerProfileImagePath = json["customer_profile_image_path"];
    customerProfileImageName = json["customer_profile_image_name"];
    customerName = json["customer_name"];
    ratings = json["ratings"];
    review = json["review"];
    createdAt = json["created_at"];

  }

}
