class CustomerFavouritesShopReqModel {
  int? shopId;

  CustomerFavouritesShopReqModel({
    required this.shopId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data["shop_id"] = shopId;

    return data;
  }
}

/////Resp
class CustomerFavouritesShopResModel {
  int? status;
  String? message;

  CustomerFavouritesShopResModel({
    required this.status,
    required this.message,
  });
  CustomerFavouritesShopResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
