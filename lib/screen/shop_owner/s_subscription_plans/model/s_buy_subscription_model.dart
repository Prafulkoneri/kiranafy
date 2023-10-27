class BuySubscriptionRequestModel {
  String? subscriptionId;
  String? serviceId;
  String? paymentMode;
  String? transactionId;
  String ? paidAmount;
  String ? referalCode;
  String ? discountPercentage;

  BuySubscriptionRequestModel(
      {this.subscriptionId,
      this.serviceId,
      this.paymentMode,
        this.paidAmount,
        this.referalCode,
        this.discountPercentage,
      this.transactionId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["subscription_id"] = subscriptionId;
    data["service_id"] = serviceId;
    data["payment_mode"] = paymentMode;
    data["transaction_id"] = transactionId;
    data["paid_amount"] = paidAmount;
    data["referral_code"] = referalCode;
    data["discount_percentage"] = discountPercentage;
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
