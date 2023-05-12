class ShopSubscriptionPlansResModel {
  String? status;
  String? message;
  List<SubscriptionData>? subscriptionData;

  ShopSubscriptionPlansResModel({this.status, this.message, this.subscriptionData});

  ShopSubscriptionPlansResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    if (json["data"] != null) {
      subscriptionData = <SubscriptionData>[];
      json["data"].forEach((v) {
        subscriptionData!.add(SubscriptionData.fromJson(v));
      });
    }
  }
}

class SubscriptionData{
  String? id;
  String? planName;
  String? subscriptionPrice;
  String? validityNumbers;
  String? validityIn;
  String? planBenifits;

  SubscriptionData(
      {this.id,
      this.planBenifits,
      this.planName,
      this.subscriptionPrice,
      this.validityIn,
      this.validityNumbers});

  SubscriptionData.fromJson(Map<String, dynamic> json) {
    json["id"] = id;
    json["plan_name"] = planName;
    json["subscription_price"] = subscriptionPrice;
    json["validity_numbers"] = validityNumbers;
    json["validity_in"] = validityIn;
    json["plan_benifits"] = planBenifits;
  }
}
