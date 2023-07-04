class DeleteProductUnitCategoryRequestModel {
  String? productUnitId;
  String? productType;
  DeleteProductUnitCategoryRequestModel({
    this.productUnitId,
    this.productType,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["product_unit_id"] = productUnitId;
    data["product_type"] = productType;
    return data;
  }
}

////////////////////////RESPONSE MODEL////////////////////
class DeleteProductUnitCategoryResModel {
  int? status;
  String? message;

  DeleteProductUnitCategoryResModel({
    required this.status,
    required this.message,
  });
  DeleteProductUnitCategoryResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
