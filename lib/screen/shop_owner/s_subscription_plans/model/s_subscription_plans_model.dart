class ShopSubscriptionPlansResModel {
  int? status;
  String? message;
  List<SubscriptionData>? subscriptionData;
  List<AddOnServicesList>? addOnServicesList;

  ShopSubscriptionPlansResModel({
    required this.status,
    required this.message,
    required this.subscriptionData,
    required this.addOnServicesList,
  });

  ShopSubscriptionPlansResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];

    if (json["data"] != null) {
      subscriptionData = <SubscriptionData>[];
      json["data"].forEach((v) {
        subscriptionData!.add(SubscriptionData.fromJson(v));
      });
    }
    if (json["add_on_services_list"] != null) {
      addOnServicesList = <AddOnServicesList>[];
      json["add_on_services_list"].forEach((v) {
        addOnServicesList!.add(AddOnServicesList.fromJson(v));
      });
    }
  }
}

class AddOnServicesList {
  int? id;
  String? addOnService;

  AddOnServicesList({
    required this.id,
    required this.addOnService,
  });

  AddOnServicesList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    addOnService = json["add_on_service"];
  }
}

class SubscriptionData {
  int? id;
  String? planName;
  int? subscriptionPrice;
  int? validityNumbers;
  String? validityIn;
  String? planBenifits;

  SubscriptionData({
    required this.id,
    required this.planName,
    required this.subscriptionPrice,
    required this.validityNumbers,
    required this.validityIn,
    required this.planBenifits,
  });

  SubscriptionData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    planName = json["plan_name"];
    subscriptionPrice = json["subscription_price"];
    validityNumbers = json["validity_numbers"];
    validityIn = json["validity_in"];
    planBenifits = json["plan_benifits"];
  }
}
