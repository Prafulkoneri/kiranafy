// class AllNearShopsReqModel {
//   String? pincode;

//   AllNearShopsReqModel({
//     required this.pincode,
//   });

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};

//     data["pincode"] = pincode;

//     return data;
//   }
// }

////Response Model
class AllNearShopsResModel {
  int? status;
  String? message;
  List<AllNearShops>? data;
  List<HomeScreenCouponData> ? couponData;

  AllNearShopsResModel({
    required this.status,
    required this.message,
    required this.data,
    required this.couponData
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
    if (json["coupon_list"] != null) {
      couponData = <HomeScreenCouponData>[];
      json["coupon_list"].forEach((v) {
        couponData!.add(HomeScreenCouponData.fromJson(v));
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
    shopName = json["shop_name"];
    // shopAreaId = json["shop_area_id"];
    // shopCityId = json["shop_city_id"];
    areaName = json["area_name"];
    cityName = json["city_name"];
    shopBannerImagePath = json["shop_banner_image_path"];
    isFavourite = json["is_favourite"];
  }
}

class HomeScreenCouponData{
  int ? id;
  int ? shopId;
  String ? shopName;
  String ? couponToDate;
  String ? couponDiscountPercentage;
  String ? couponMinimumOrderAmount;
  String ? couponDiscountMaxAmount;
  String ? couponCode;
  String ? couponTermsAndCondition;
  HomeScreenCouponData({
    this.id,this.shopId,this.couponDiscountMaxAmount,this.shopName,this.couponDiscountPercentage,this.couponCode,this.couponTermsAndCondition,this.couponMinimumOrderAmount,this.couponToDate
});
  HomeScreenCouponData.fromJson(Map<String,dynamic>json){
    id=json["id"];
    shopId=json["shop_id"];
    shopName=json["shop_name"];
    couponToDate=json["coupon_to_date"];
    couponDiscountPercentage=json["coupon_discount_percentage"];
    couponMinimumOrderAmount=json["coupon_minimum_order_amount"];
    couponDiscountMaxAmount=json["coupon_discount_max_amount"];
    couponCode=json["coupon_code"];
    couponTermsAndCondition=json["coupon_terms_and_conditions"];
  }
}
