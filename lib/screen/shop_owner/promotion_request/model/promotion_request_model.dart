///////////////Request Model///////////////////
class PromotionRequestRequestModel {
  String? promotionSubject;
  String? planStartDateFromShopOwner;
  String? adsContent;
  String? adsPlan;

  PromotionRequestRequestModel({
    this.promotionSubject,
    this.planStartDateFromShopOwner,
    this.adsContent,
    this.adsPlan,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["promotion_subject"] = promotionSubject;
    data["plan_start_date_from_shop_owner"] = planStartDateFromShopOwner;
    data["ads_content"] = adsContent;
    data["ads_plan"] = adsPlan;

    return data;
  }
}

/////////////////////Pramotion Reponse Model///////////////////
class PromotionRequestResponseModel {
  int? status;
  String? message;

  PromotionRequestResponseModel({
    required this.status,
    required this.message,
  });
  PromotionRequestResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
