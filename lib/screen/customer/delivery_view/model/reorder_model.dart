class CustomerReorderRequestModel {
  String? orderId;

  CustomerReorderRequestModel({
    this.orderId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["order_id"] = orderId;

    return data;
  }
}

////////////////////////////////////////RESPONSE MODEL////////////////////////////////////
class CustomerReorderResponseModel {
  int? status;
  String? message;

  CustomerReorderResponseModel({
    required this.status,
    required this.message,
  });
  CustomerReorderResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
