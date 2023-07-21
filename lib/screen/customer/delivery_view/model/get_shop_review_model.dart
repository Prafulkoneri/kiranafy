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

  CustomerGetShopReviewListResponseModel({
    required this.status,
    required this.message,
  });
  CustomerGetShopReviewListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    // orderData =
    //     json['data'] != null ? OrderViewData.fromJson(json['data']) : null;
  }
}
