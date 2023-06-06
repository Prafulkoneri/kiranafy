////Request Model
class RemoveCustomProductReqModel {
  String? shopId;
  String? productId;

  RemoveCustomProductReqModel({
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
class RemoveCustomProductResModel {
  int? status;
  String? message;
  RemoveCustomProductResModel({
    this.status,
    this.message,
  });
  RemoveCustomProductResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
