class CartDetailDeleteRequestModel {
  String? cartId;

  CartDetailDeleteRequestModel({
    this.cartId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["cart_id"] = cartId;

    return data;
  }
}

/////////////RESPOnse////////
class CartDetailDeleteResponseModel {
  int? status;
  String? message;

  CartDetailDeleteResponseModel({
    required this.status,
    required this.message,
  });
  CartDetailDeleteResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
