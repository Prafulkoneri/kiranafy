class AccountDetailsResModel {
  int? status;
  String? message;
  ShopDetailsData? shopDetails;
  List<CountryData>? countries;
  List<StatedData>? states;
  List<CityData>? cities;
  List<AreaData>? areas;
  List<ShopBannerImageData>? shopBannerImages;

  AccountDetailsResModel({
    required this.status,
    required this.message,
    required this.shopDetails,
    required this.countries,
    required this.states,
    required this.cities,
    required this.areas,
    required this.shopBannerImages,
  });

  AccountDetailsResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];

    //array Shop Details

    shopDetails = json['shop_details'] != null
        ? ShopDetailsData.fromJson(json['shop_details'])
        : null;

    //list Country
    if (json["countries"] != null) {
      countries = <CountryData>[];
      json["countries"].forEach((v) {
        countries!.add(CountryData.fromJson(v));
      });
    }

//list State
    if (json["states"] != null) {
      states = <StatedData>[];
      json["states"].forEach((v) {
        states!.add(StatedData.fromJson(v));
      });
    }

    ///list Cities
    if (json["cities"] != null) {
      cities = <CityData>[];
      json["cities"].forEach((v) {
        cities!.add(CityData.fromJson(v));
      });
    }

    ///list Areas
    if (json["areas"] != null) {
      areas = <AreaData>[];
      json["areas"].forEach((v) {
        areas!.add(AreaData.fromJson(v));
      });
    }

    ///list Banner Images
    if (json["shop_banner_images"] != null) {
      shopBannerImages = <ShopBannerImageData>[];
      json["shop_banner_images"].forEach((v) {
        shopBannerImages!.add(ShopBannerImageData.fromJson(v));
      });
    }
  }
}

////Area
class AreaData {
  int? id;
  String? areaName;

  AreaData({
    required this.id,
    required this.areaName,
  });

  AreaData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    areaName = json["area_name"];
  }
}

////CityData

class CityData {
  int? id;
  String? cityName;

  CityData({
    required this.id,
    required this.cityName,
  });

  CityData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    cityName = json["city_name"];
  }
}

////Country
class CountryData {
  int? id;
  String? countryName;

  CountryData({
    required this.id,
    required this.countryName,
  });

  CountryData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    countryName = json["country_name"];
  }
}

class ShopBannerImageData {
  int? id;
  String? shopBannerImagePath;
  String? shopBannerImageName;

  ShopBannerImageData({
    required this.id,
    required this.shopBannerImagePath,
    required this.shopBannerImageName,
  });
  ShopBannerImageData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    shopBannerImagePath = json["shop_banner_image_path"];
    shopBannerImageName = json["shop_banner_image_name"];
  }
}

class ShopDetailsData {
  String? shopName;
  String? shopOwnerName;
  String? shopOwnerCountryCode;
  int? shopOwnerMobileNumber;
  String? shopOwnerEmail;
  int? selectedCountryId;
  String? countryName;
  int? selectedStateId;
  String? stateName;
  int? selectedCityId;
  String? cityName;
  int? selectedAreaId;
  String? areaName;
  String? shopAddress;
  int? shopPincode;

  ShopDetailsData({
    required this.shopName,
    required this.shopOwnerName,
    required this.shopOwnerCountryCode,
    required this.shopOwnerMobileNumber,
    required this.shopOwnerEmail,
    required this.selectedCountryId,
    required this.countryName,
    required this.selectedStateId,
    required this.stateName,
    required this.selectedCityId,
    required this.cityName,
    required this.selectedAreaId,
    required this.areaName,
    required this.shopAddress,
    required this.shopPincode,
  });

  ShopDetailsData.fromJson(Map<String, dynamic> json) {
    shopName = json["shop_name"];
    shopOwnerName = json["shop_owner_name"];
    shopOwnerCountryCode = json["shop_owner_country_code"];
    shopOwnerMobileNumber = json["shop_owner_mobile_number"];
    shopOwnerEmail = json["shop_owner_email"];
    selectedCountryId = json["selected_country_id"];
    countryName = json["country_name"];
    selectedStateId = json["selected_state_id"];
    stateName = json["state_name"];
    selectedCityId = json["selected_city_id"];
    cityName = json["city_name"];
    selectedAreaId = json["selected_area_id"];
    areaName = json["area_name"];
    shopAddress = json["shop_address"];
    shopPincode = json["shop_pincode"];
  }
}

class StatedData {
  int? id;
  String? stateName;

  StatedData({
    required this.id,
    required this.stateName,
  });

  ////maping data
  StatedData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    stateName = json["state_name"];
  }
}
