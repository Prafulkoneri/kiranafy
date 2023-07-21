class SubmitReviewRequestModel {
  String? shopId;
  String? orderId;
  String? review;
  String? rating;

  SubmitReviewRequestModel(
      {this.shopId, this.orderId, this.review, this.rating});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["shop_id"] = shopId;
    data["order_id"] = orderId;
    data["review"] = review;
    data["ratings"] = rating;

    return data;
  }
}

///////////////////////////////////////////////////////////////////////////
class SubmitReviewResponseModel {
  int? status;
  String? message;

  SubmitReviewResponseModel({
    required this.status,
    required this.message,
  });
  SubmitReviewResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    // orderData =
    //     json['data'] != null ? OrderViewData.fromJson(json['data']) : null;
  }
}
