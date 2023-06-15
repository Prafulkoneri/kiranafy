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
  ItemQuantityData ? itemQuantityData;


  CartItemQuantityResponseModel({
    required this.status,
    required this.message,

  });
  CartItemQuantityResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    itemQuantityData = json['data'] != null ? ItemQuantityData.fromJson(json['data']) : null;
  }
}

class ItemQuantityData{
  String ? itemCount;
  int ? totalAmount;
  int ? totalSavedAmount;
  ItemQuantityData({
    this.itemCount,
    this.totalAmount,
    this.totalSavedAmount
});
  ItemQuantityData.fromJson(Map<String,dynamic>json){
    itemCount = json["item_count"];
    totalAmount = json["total_amount"];
    totalSavedAmount = json["total_saved_amount"];
  }
}
