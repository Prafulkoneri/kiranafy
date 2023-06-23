class OrderStatusChangeRequestModel {
  String? orderId;
  String? orderStatus;
  String? orderCancelledReason;
  String? orderCancelledReasonId;
  String? deliveryCode;

  OrderStatusChangeRequestModel(
      {this.orderId,
      this.orderStatus,
      this.orderCancelledReason,
      this.orderCancelledReasonId,
      this.deliveryCode});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["order_id"] = orderId;
    data["order_status"] = orderStatus;
    data["shop_owner_order_cancelled_reason"] = orderCancelledReason;
    data["shop_owner_cancelled_reason_id"] = orderCancelledReasonId;
    data["delivery_code"] = deliveryCode;

    return data;
  }
}

//////////////////ResPonse Model/////////////
class OrderStatusChangeResModel {
  int? status;
  String? message;

  OrderStatusChangeResModel({
    required this.status,
    required this.message,
  });
  OrderStatusChangeResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
