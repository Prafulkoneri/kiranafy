// class ShopAsPerCategetoryResModel {
//   int? status;
//   String? message;
//   Data? data;

//   ShopAsPerCategetoryResModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });
//   ShopAsPerCategetoryResModel.fromJson(Map<String, dynamic> json) {
//     status = json["status"];
//     message = json["message"];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
// }

// class Data {
//   List<NearShops>? nearbyShops;
//   List<AllShop>? allShops;

//   Data({
//     required this.nearbyShops,
//     required this.allShops,
//   });
//    Data.fromJson(Map<String, dynamic> json) {
   
//  if (json["nearby_shops"] != null) {
//       nearbyShops = <NearShops>[];
//       json["nearby_shops"].forEach((v) {
//         nearbyShops!.add(NearShops.fromJson(v));
//       });
//     }
//     if (json["all_shops"] != null) {
//       allShops = <AllShop>[];
//       json["all_shops"].forEach((v) {
//         allShops!.add(AllShop.fromJson(v));
//       });
//     }
//   }
// }

// class AllShop {
//   int? id;
//   String? shopName;
//   String? areaName;
//   String? cityName;
//   String? shopBannerImagePath;
//   String? isFavourite;

//   AllShop({
//     required this.id,
//     required this.shopName,
//     required this.areaName,
//     required this.cityName,
//     required this.shopBannerImagePath,
//     required this.isFavourite,
//   });
//     AllShop.fromJson(Map<String, dynamic> json) {
//     id = json["id"];
//     shopName = json["shop_banner_image_name"];
//     areaName = json["shop_banner_image_name"];
//     cityName = json["shop_banner_image_name"];
//     shopBannerImagePath = json["shop_banner_image_path"];
//     isFavourite = json["shop_banner_image_name"];
    
    
//   }

// }

// class NearShops {
//   int id;
//   String shopName;
//   String areaName;
//   String cityName;
//   String shopBannerImagePath;
//   String isFavourite;

//   NearShops({
//     required this.id,
//     required this.shopName,
//     required this.areaName,
//     required this.cityName,
//     required this.shopBannerImagePath,
//     required this.isFavourite,
//   });
// }
