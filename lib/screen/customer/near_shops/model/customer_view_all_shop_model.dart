class CustomerViewAllShopReqModel {
  String? pincode;
  String? limit;
  String? offset;
  String ? areaId;
  String ? rating;
  CustomerViewAllShopReqModel({
    this.pincode,
    this.limit,
    this.offset,
    required this.areaId,
    required this.rating,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["pincode"] = pincode;
    data["limit"] = limit;
    data["offset"] = offset;
    data["area_id"] = areaId;
    data["rating"] = rating;
    return data;
  }
}

class CustomerViewAllShopResModel {
  int? status;
  String? message;
  Data? data;

  CustomerViewAllShopResModel({
    this.status,
    this.data,
    this.message,
  });
  CustomerViewAllShopResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<NearByShops>? nearByShops;
  List<AllShops>? allShops;
  Data({
    this.allShops,
    this.nearByShops,
  });
  Data.fromJson(Map<String, dynamic> json) {
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

class NearByShops {
  int? id;
  String? shopName;
  String? areaName;
  String? cityName;
  String? shopBannerImagePath;
  String? isFavourite;

  NearByShops({
    required this.id,
    required this.shopName,
    required this.areaName,
    required this.cityName,
    required this.shopBannerImagePath,
    required this.isFavourite,
  });
  NearByShops.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    shopName = json["shop_name"];
    areaName = json["area_name"];
    cityName = json["city_name"];
    shopBannerImagePath = json["shop_banner_image_path"];
    isFavourite = json["is_favourite"];
  }
}

class AllShops {
  int? id;
  String? shopName;
  String? areaName;
  String? cityName;
  String? shopBannerImagePath;
  String? isFavourite;
  String? ratings;

  AllShops({
    required this.id,
    required this.shopName,
    required this.areaName,
    required this.cityName,
    required this.shopBannerImagePath,
    required this.isFavourite,
    required this.ratings,
  });
  AllShops.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    shopName = json["shop_name"];
    areaName = json["area_name"];
    cityName = json["city_name"];
    shopBannerImagePath = json["shop_banner_image_path"];
    isFavourite = json["is_favourite"];
    ratings = json["ratings"];
  }
}
