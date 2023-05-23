class GetAllFavShopsResModel{
  int ? status;
  String ? message;
  List<FavouriteData> ? data;
  GetAllFavShopsResModel({
    this.status,
    this.data,
    this.message,
});
  GetAllFavShopsResModel.fromJson(Map<String,dynamic>json){
    status=json["status"];
    message=json["message"];
    if (json["data"] != null) {
      data = <FavouriteData>[];
      json["data"].forEach((v) {
        data!.add(FavouriteData.fromJson(v));
      });
    }
  }
}

class FavouriteData{
int ? favouriteId;
int ? id;
String ? shopName;
int ? shopAreaId;
int ? shopCityId;
String ? areaName;
String ? cityName;
String ? shopBannerImagePath;
FavouriteData({
  this.id,this.shopBannerImagePath,this.shopName,this.areaName,this.cityName,this.favouriteId,this.shopAreaId,this.shopCityId
});
FavouriteData.fromJson(Map<String,dynamic>json){
  favouriteId=json["favourite_id"];
  id=json["id"];
  shopName=json["shop_name"];
  shopAreaId=json["shop_area_id"];
  shopCityId=json["shop_city_id"];
  areaName=json["area_name"];
  cityName=json["city_name"];
  shopBannerImagePath=json["shop_banner_image_path"];
}
}