class RemoveSRFProductsRequestModel {
  String? productId;
  String? productsType;
  String? removeFrom;

  RemoveSRFProductsRequestModel({
    this.productId,
    this.productsType,
    this.removeFrom,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["product_id"] = productId;
    data["product_type"] = productsType;
    data["remove_from"] = removeFrom;
    return data;
  }
}

/////////////////////RESPONSE MODEL/////////////////////
class RemoveSRFProductsResponseModel {
  int? status;
  String? message;

  RemoveSRFProductsResponseModel({
    required this.status,
    required this.message,
  });
  RemoveSRFProductsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
