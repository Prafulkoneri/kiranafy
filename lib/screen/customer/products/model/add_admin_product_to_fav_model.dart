////Request Model
class AddAdminProductToFavReqModel {
  String? shopId;
  String? productId;

  AddAdminProductToFavReqModel({
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

///////Response Model////
class AddAdminProductToFavResModel {
  int? status;
  String? message;
  AddAdminProductToFavResModel({
    this.status,
    this.message,
  });
  AddAdminProductToFavResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
