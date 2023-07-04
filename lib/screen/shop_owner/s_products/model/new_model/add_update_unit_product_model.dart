class AddUpdateUnitProductCategoryRequestModel {
  String? productUnitId;
  String? productType;
  AddUpdateUnitProductCategoryRequestModel({
    this.productUnitId,
    this.productType,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["action_type"] = productUnitId;
    data["product_id"] = productType;
    data["unit_id"] = productType;
    data["weight"] = productType;
    data["mrp_price"] = productType;
    data["offer_price"] = productType;
    data["status"] = productType;
    data["product_unit_id"] = productType;
    data["unit_based_product_image_1_path"] = productType;
    data["unit_based_product_image_2_path"] = productType;
    data["unit_based_product_image_3_path"] = productType;
    data["product_type"] = productType;

    return data;
  }
}

////////////////////////RESPONSE MODEL////////////////////
class AddUpdateUnitProductCategoryResModel {
  int? status;
  String? message;

  AddUpdateUnitProductCategoryResModel({
    required this.status,
    required this.message,
  });
  AddUpdateUnitProductCategoryResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
