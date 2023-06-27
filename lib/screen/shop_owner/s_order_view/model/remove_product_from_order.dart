///////////////REQUEST MODEL//////////////
class RemoveProductFromOrderReqModel {
  String? orderProductId;

  RemoveProductFromOrderReqModel({
    this.orderProductId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["order_product_id"] = orderProductId;

    return data;
  }
}

//////////////////RESPONSE MODEL///////////////////////
class RemoveProductFromOrderResModel {
  int? status;
  String? message;

  RemoveProductFromOrderResModel({
    required this.status,
    required this.message,
  });
  RemoveProductFromOrderResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
