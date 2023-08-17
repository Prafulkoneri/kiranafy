class RemoveItemFromCartReq {
  String? productUnitId;
  String? productType;
  String? quantity;
  String? shopId;

  RemoveItemFromCartReq({
    this.productUnitId,
    this.productType,
    this.quantity,
    this.shopId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["product_unit_id"] = productUnitId;
    data["product_type"] = productType;
    data["quantity"] = quantity;
    data["shop_id"] = shopId;
    return data;
  }
}

////////////////////////////////////RESPONSe//////////////////////////
class CartRemoveResponseModel {
  int? status;
  String? message;

  CartRemoveResponseModel({
    required this.status,
    required this.message,
  });
  CartRemoveResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
