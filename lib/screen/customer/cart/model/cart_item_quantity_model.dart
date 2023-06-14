class CartItemQuantityReqModel {
  String? cartItemId;
  String? quantityAction;

  CartItemQuantityReqModel({this.cartItemId, this.quantityAction});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["cart_item_id"] = cartItemId;
    data["quantity_action"] = quantityAction;
    return data;
  }
}

///////////RESPonse//////
class CartItemQuantityResponseModel {
  int? status;
  String? message;

  CartItemQuantityResponseModel({
    required this.status,
    required this.message,
  });
  CartItemQuantityResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
