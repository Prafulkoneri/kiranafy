class AddUpdateUnitProductCategoryRequestModel {
  String? actionType;
  String? productId;
  String? unitId;
  String? weight;
  String? mrpPrice;
  String? offerPrice;
  String? status;
  String? productUnitId;
  String? unitBasedProductImage1Path;
  String? unitBasedProductImage2Path;
  String? unitBasedProductImage3Path;
  String? productType;
  AddUpdateUnitProductCategoryRequestModel({
    this.actionType,
    this.productId,
    this.unitId,
    this.weight,
    this.mrpPrice,
    this.offerPrice,
    this.status,
    this.productUnitId,
    this.unitBasedProductImage1Path,
    this.unitBasedProductImage2Path,
    this.unitBasedProductImage3Path,
    this.productType,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["action_type"] = actionType;
    data["product_id"] = productId;
    data["unit_id"] = unitId;
    data["weight"] = weight;
    data["mrp_price"] = mrpPrice;
    data["offer_price"] = offerPrice;
    data["status"] = status;
    data["product_unit_id"] = productUnitId;
    data["unit_based_product_image_1_path"] = unitBasedProductImage1Path;
    data["unit_based_product_image_2_path"] = unitBasedProductImage2Path;
    data["unit_based_product_image_3_path"] = unitBasedProductImage3Path;
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
