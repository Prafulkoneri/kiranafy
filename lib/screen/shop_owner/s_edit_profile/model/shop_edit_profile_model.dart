import 'package:local_supper_market/screen/shop_owner/s_auth/model/area_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/city_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/country_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/state_model.dart';

class AccountDetailsResModel {
  int? status;
  String? message;
  String? kycStatus;
  ShopDetailsData? shopDetails;
  List<CountryData>? countries;
  List<StateData>? states;
  List<CityData>? cities;
  List<AreaData>? areas;
  List<ShopBannerImageData>? shopBannerImages;
  List? pincode;

  AccountDetailsResModel({
    required this.status,
    required this.message,
    required this.shopDetails,
    required this.countries,
    required this.states,
    required this.cities,
    required this.areas,
    required this.shopBannerImages,
    required this.pincode,
    required this.kycStatus,
  });

  AccountDetailsResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    kycStatus = json["shop_owner_kyc_status"];

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
      states = <StateData>[];
      json["states"].forEach((v) {
        states!.add(StateData.fromJson(v));
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

    if (json["pincodes"] != null) {
      pincode = [];
      json["pincodes"].forEach((v) {
        pincode!.add(v);
      });
    }

    ///list Banner Images
    if (json["shop_banner_images"] != null) {
      shopBannerImages = <ShopBannerImageData>[];
      json["shop_banner_images"].forEach((v) {
        shopBannerImages!.add(ShopBannerImageData.fromJson(v));
      });
    }
    ///////
  }
}

////Area

////CityData

////Country

class ShopBannerImageData {
  int? id;
  String? shopBannerImagePath;
  String? shopBannerImageName;
  int? shopBannerSequence;

  ShopBannerImageData({
    required this.id,
    required this.shopBannerImagePath,
    required this.shopBannerImageName,
    required this.shopBannerSequence,
  });

  ShopBannerImageData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    shopBannerImagePath = json["shop_banner_image_path"];
    shopBannerImageName = json["shop_banner_image_name"];
    shopBannerSequence = json["shop_banner_sequence"];
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
