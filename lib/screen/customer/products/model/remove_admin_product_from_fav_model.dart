////Request Model
class RemoveAdminProductReqModel {
  String? shopId;
  String? productId;

  RemoveAdminProductReqModel({
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
class RemoveAdminProductResModel {
  int? status;
  String? message;
  RemoveAdminProductResModel({
    this.status,
    this.message,
  });
  RemoveAdminProductResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
