class ShopSubscriptionPlansResModel {
  int? status;
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
  int? id;
  String? planName;
  int? subscriptionPrice;
  int? validityNumbers;
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
     id = json["id"] ;
     planName = json["plan_name"]  ;
     subscriptionPrice = json["subscription_price"]  ;
     validityNumbers  = json["validity_numbers"];
    validityIn = json["validity_in"] ;
     planBenifits = json["plan_benifits"] ;
  }
}
