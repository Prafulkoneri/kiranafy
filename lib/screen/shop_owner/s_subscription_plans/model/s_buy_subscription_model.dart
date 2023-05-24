class BuySubscriptionRequestModel {
  String? subscriptionId;
  String? serviceId;

  BuySubscriptionRequestModel({this.subscriptionId, this.serviceId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["subscription_id"] = subscriptionId;
    data["service_id"] = subscriptionId;
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
