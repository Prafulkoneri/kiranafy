class CustomerAdsRequestmodel {
  String? name;
  String? number;
  String? shopName;
  String? planStartDateFrom;
  String? adsContent;
  String? adsPlan;

  CustomerAdsRequestmodel({
    this.name,
    this.number,
    this.shopName,
    this.planStartDateFrom,
    this.adsContent,
    this.adsPlan,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["customer_name"] = name;
    data["mobile_no"] = number;
    data["shop_name"] = shopName;
    data["plan_start_date_from_customer"] = planStartDateFrom;
    data["ads_content"] = adsContent;
    data["ads_plan"] = adsPlan;

    return data;
  }
}
//////////////////////Response Model////////////
class CustomerAdsResponsemodel {
  int? status;
  String? message;

  CustomerAdsResponsemodel({
    required this.status,
    required this.message,
  });

  CustomerAdsResponsemodel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}