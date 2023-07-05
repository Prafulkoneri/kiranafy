class GetProductUitListRequestModel {
  String? productId;
  String? productType;
  GetProductUitListRequestModel({
    this.productId,
    this.productType,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["product_type"] = productType;
    data["product_id"] = productId;
    return data;
  }
}
