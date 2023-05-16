class BuySubscriptionRequestModel {
  String? subscriptionId;

  BuySubscriptionRequestModel({
    this.subscriptionId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["subscription_id"] = subscriptionId;

    return data;
  }
}

///response model
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
