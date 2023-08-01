// class GetSubscriptionHistoryModel {
//   int? status;
//   String? message;
//   SubcriptionData? subscriptiondata;

//   GetSubscriptionHistoryModel({
//     required this.status,
//     required this.message,
//     required this.subscriptiondata,
//   });
// GetSubscriptionHistoryModel.fromJson(Map<String, dynamic> json) {
//   status = json["status"];
//   message = json["message"];
//   subscriptiondata =
//       json['data'] != null ? SubcriptionData.fromJson(json['data']) : null;
// }
// }

// class SubcriptionData {
//   CurrentSubscriptionPlan? currentSubscriptionPlan;
//   List<SubscriptionHistory>? subscriptionHistory;

//   SubcriptionData({
//     required this.currentSubscriptionPlan,
//     required this.subscriptionHistory,
//   });
// SubcriptionData.fromJson(Map<String, dynamic> json) {
//   currentSubscriptionPlan = json['current_subscription_plan'] != null
//       ? CurrentSubscriptionPlan.fromJson(json['current_subscription_plan'])
//       : null;

//   //////////////////////////////////
//   if (json["subscription_history"] != null) {
//     subscriptionHistory = <SubscriptionHistory>[];
//     json["subscription_history"].forEach((v) {
//       subscriptionHistory!.add(SubscriptionHistory.fromJson(v));
//     });
//   }
// }
// }

// class CurrentSubscriptionPlan {
//   int? id;
//   String? planName;
//   String? subscriptionActiveTill;
//   String? paidAmount;
//   String? planBenifits;
//   String? subscriptionSpecialBenifits;

//   CurrentSubscriptionPlan({
//     required this.id,
//     required this.planName,
//     required this.subscriptionActiveTill,
//     required this.paidAmount,
//     required this.planBenifits,
//     required this.subscriptionSpecialBenifits,
//   });
// CurrentSubscriptionPlan.fromJson(Map<String, dynamic> json) {
//   id = json["id"];
//   planName = json["plan_name"];
//   subscriptionActiveTill = json["subscription_active_till"];
//   paidAmount = json["paid_amount"];
//   planBenifits = json["plan_benifits"];
//   subscriptionSpecialBenifits = json["subscription_special_benifits"];
// }
// }

// class SubscriptionHistory {
// int? id;
// String? planName;
// String? validity;
// String? subscriptionActiveTill;
// String? paidAmount;

// SubscriptionHistory({
//   required this.id,
//   required this.planName,
//   required this.validity,
//   required this.subscriptionActiveTill,
//   required this.paidAmount,
// });
// SubscriptionHistory.fromJson(Map<String, dynamic> json) {
//   id = json["id"];
//   planName = json["plan_name"];
//   validity = json["validity"];
//   subscriptionActiveTill = json["subscription_active_till"];
//   paidAmount = json["paid_amount"];
// }
// }

class GetSubscriptionHistoryModel {
  int? status;
  String? message;
  SubcriptionData? subscriptiondata;

  GetSubscriptionHistoryModel({
    required this.status,
    required this.message,
    required this.subscriptiondata,
  });
  GetSubscriptionHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    subscriptiondata =
        json['data'] != null ? SubcriptionData.fromJson(json['data']) : null;
  }
}

class SubcriptionData {
  CurrentSubscriptionPlan? currentSubscriptionPlan;
  List<SubscriptionHistory>? subscriptionHistory;

  SubcriptionData({
    required this.currentSubscriptionPlan,
    required this.subscriptionHistory,
  });
  SubcriptionData.fromJson(Map<String, dynamic> json) {
    currentSubscriptionPlan = json['current_subscription_plan'] != null
        ? CurrentSubscriptionPlan.fromJson(json['current_subscription_plan'])
        : null;

    //////////////////////////////////
    if (json["subscription_history"] != null) {
      subscriptionHistory = <SubscriptionHistory>[];
      json["subscription_history"].forEach((v) {
        subscriptionHistory!.add(SubscriptionHistory.fromJson(v));
      });
    }
  }
}

class CurrentSubscriptionPlan {
  int? id;
  String? planName;
  String? subscriptionActiveTill;
  String? paidAmount;
  String? planBenifits;
  List? subscriptionSpecialBenifits;

  CurrentSubscriptionPlan({
    required this.id,
    required this.planName,
    required this.subscriptionActiveTill,
    required this.paidAmount,
    required this.planBenifits,
    required this.subscriptionSpecialBenifits,
  });
  CurrentSubscriptionPlan.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    planName = json["plan_name"];
    subscriptionActiveTill = json["subscription_active_till"];
    paidAmount = json["paid_amount"];
    planBenifits = json["plan_benifits"];
    // subscriptionSpecialBenifits = json["subscription_special_benifits"];
    //////////////
    if (json["subscription_special_benifits"] != null) {
      subscriptionSpecialBenifits = [];
      json["subscription_special_benifits"].forEach((v) {
        subscriptionSpecialBenifits!.add((v));
      });
    }
  }
}

class SubscriptionHistory {
  int? id;
  String? planName;
  String? validity;
  String? subscriptionActiveTill;
  String? paidAmount;

  SubscriptionHistory({
    required this.id,
    required this.planName,
    required this.validity,
    required this.subscriptionActiveTill,
    required this.paidAmount,
  });

  SubscriptionHistory.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    planName = json["plan_name"];
    validity = json["validity"];
    subscriptionActiveTill = json["subscription_active_till"];
    paidAmount = json["paid_amount"];
  }
}
