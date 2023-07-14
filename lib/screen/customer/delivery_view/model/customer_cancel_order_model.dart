class CustomerCancelOrderRequestModel {
  String? orderId;
  String? orderCancelledReason;
  String? orderCancelledReasonId;

  CustomerCancelOrderRequestModel(
      {required this.orderId,
      required this.orderCancelledReason,
      required this.orderCancelledReasonId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["order_id"] = orderId;
    data["order_cancelled_reason"] = orderCancelledReason;
    data["cancelled_reason_id"] = orderCancelledReasonId;
    return data;
  }
}

////////////////////////////////Response Model////////////////////////////
class CustomerCancelOrderResModel {
  int? status;
  String? message;

  CustomerCancelOrderResModel({
    required this.status,
    required this.message,
  });
  CustomerCancelOrderResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
