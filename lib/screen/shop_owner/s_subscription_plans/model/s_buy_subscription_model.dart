class BuySubscriptionRequestModel {
  String? subscriptionId;
  String? serviceId;
  String? paymentMode;
  String? transactionId;

  BuySubscriptionRequestModel(
      {this.subscriptionId,
      this.serviceId,
      this.paymentMode,
      this.transactionId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["subscription_id"] = subscriptionId;
    data["service_id"] = serviceId;
    data["payment_mode"] = paymentMode;
    data["transaction_id"] = transactionId;
    return data;
  }
}

class BuySubscriptionResponseModel {
  int? status;
  String? message;

  BuySubscriptionResponseModel({
    required this.status,
    required this.message,
  });

  BuySubscriptionResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
