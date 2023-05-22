class UpdateProfileDetailReqModel {
  int? customerPincode;

  UpdateProfileDetailReqModel({
    required this.customerPincode,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data["customer_pincode"] = customerPincode;

    return data;
  }
}

////Response Model
class AllNearShopsResModel {
  int? status;
  String? message;
  List<AllNearShops>? data;

  AllNearShopsResModel({
    required this.status,
    required this.message,
    required this.data,
  });
  AllNearShopsResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];

    if (json["data"] != null) {
      data = <AllNearShops>[];
      json["data"].forEach((v) {
        data!.add(AllNearShops.fromJson(v));
      });
    }
  }
}

class AllNearShops {
  int? id;
  String? shopName;
  int? shopAreaId;
  int? shopCityId;
  String? areaName;
  String? cityName;
  String? shopBannerImagePath;
  String? isFavourite;

  AllNearShops({
    required this.id,
    required this.shopName,
    required this.shopAreaId,
    required this.shopCityId,
    required this.areaName,
    required this.cityName,
    required this.shopBannerImagePath,
    required this.isFavourite,
  });
  AllNearShops.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    shopName = json["country_name"];
    shopAreaId = json["country_name"];
    areaName = json["country_name"];
    cityName = json["country_name"];
    shopBannerImagePath = json["country_name"];
    isFavourite = json["country_name"];
  }
}
