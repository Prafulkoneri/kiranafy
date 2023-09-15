import 'package:local_supper_market/screen/customer/near_shops/model/customer_view_all_shop_model.dart';

class SearchShopRequestModel {
  String? shopName;

  SearchShopRequestModel({
    this.shopName,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["shop_name"] = shopName;

    return data;
  }
}
/////////////////Request Model////////////////

class SearchShopResponseModel {
  int? status;
  String? message;
  SearchShopData? searchshopData;

  SearchShopResponseModel({
    required this.status,
    required this.message,
    required this.searchshopData,
  });
  SearchShopResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    searchshopData =
        json['data'] != null ? SearchShopData.fromJson(json['data']) : null;
  }
}

class SearchShopData {
  List<NearByShops>? nearByShops;
  List<AllShops>? allShops;

  SearchShopData({
    required this.nearByShops,
    required this.allShops,
  });
  SearchShopData.fromJson(Map<String, dynamic> json) {
    if (json["nearby_shops"] != null) {
      nearByShops = <NearByShops>[];
      json["nearby_shops"].forEach((v) {
        nearByShops!.add(NearByShops.fromJson(v));
      });
    }
    if (json["all_shops"] != null) {
      allShops = <AllShops>[];
      json["all_shops"].forEach((v) {
        allShops!.add(AllShops.fromJson(v));
      });
    }
  }
}
