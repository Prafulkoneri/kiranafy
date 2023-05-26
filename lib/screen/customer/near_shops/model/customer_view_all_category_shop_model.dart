class CustomerViewAllCategoryShopReqModel {
  String? pincode;
  String? limit;
  String? offset;
  String? categoryId;
  CustomerViewAllCategoryShopReqModel({
    this.pincode,
    this.limit,
    this.offset,
    this.categoryId,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["pincode"] = pincode;
    data["limit"] = limit;
    data["offset"] = offset;
    data["category_id"] = categoryId;
    return data;
  }
}

class CustomerViewAllCategoryShopResModel {
  int? status;
  String? message;
  Data? data;

  CustomerViewAllCategoryShopResModel({
    this.status,
    this.data,
    this.message,
  });
  CustomerViewAllCategoryShopResModel.fromJson(Map<String, dynamic> json) {
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
    if (json["nearby_shops_as_per_category"] != null) {
      nearByShops = <NearByShops>[];
      json["nearby_shops_as_per_category"].forEach((v) {
        nearByShops!.add(NearByShops.fromJson(v));
      });
    }
    if (json["all_shops_as_per_category"] != null) {
      allShops = <AllShops>[];
      json["all_shops_as_per_category"].forEach((v) {
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

  AllShops({
    required this.id,
    required this.shopName,
    required this.areaName,
    required this.cityName,
    required this.shopBannerImagePath,
    required this.isFavourite,
  });
  AllShops.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    shopName = json["shop_name"];
    areaName = json["area_name"];
    cityName = json["city_name"];
    shopBannerImagePath = json["shop_banner_image_path"];
    isFavourite = json["is_favourite"];
  }
}
