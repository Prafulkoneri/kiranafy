class AddCustomProductToFavReqModel {
  String? shopId;
  String? productId;

  AddCustomProductToFavReqModel({
    this.productId,
    this.shopId,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["shop_id"] = shopId;
    data["product_id"] = productId;
    return data;
  }
}

class AddCustomProductToFavResModel {
  int? status;
  String? message;
  AddCustomProductToFavResModel({
    this.status,
    this.message,
  });
  AddCustomProductToFavResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
