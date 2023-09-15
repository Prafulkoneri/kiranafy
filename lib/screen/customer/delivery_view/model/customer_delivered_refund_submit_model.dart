class CustomerDeliveredRefundStatusUpdateReqModel {
  String? orderId;
  String? paymentStatus;

  CustomerDeliveredRefundStatusUpdateReqModel({
    this.orderId,
    this.paymentStatus,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["order_id"] = orderId;
    data["shop_de_customer_payment_status"] = paymentStatus;
    return data;
  }
}

class CustomerDeliveredRefundStatusUpdateResModel {
  int? status;
  String? message;
  CustomerDeliveredRefundStatusUpdateResModel({
    this.status,
    this.message,
  });
  CustomerDeliveredRefundStatusUpdateResModel.fromJson(
      Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
