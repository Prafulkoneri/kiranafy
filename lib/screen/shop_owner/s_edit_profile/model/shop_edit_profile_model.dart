class AccountDetailsResModel {
  int status;
  String message;
  ShopDetails shopDetails;
  List<Country> countries;
  List<State> states;
  List<City> cities;
  List<Area> areas;
  List<ShopBannerImage> shopBannerImages;

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
}

class Area {
  int id;
  String areaName;

  Area({
    required this.id,
    required this.areaName,
  });
}

class City {
  int id;
  String cityName;

  City({
    required this.id,
    required this.cityName,
  });
}

class Country {
  int id;
  String countryName;

  Country({
    required this.id,
    required this.countryName,
  });
}

class ShopBannerImage {
  int id;
  String shopBannerImagePath;
  String shopBannerImageName;

  ShopBannerImage({
    required this.id,
    required this.shopBannerImagePath,
    required this.shopBannerImageName,
  });
}

class ShopDetails {
  String shopName;
  String shopOwnerName;
  String shopOwnerCountryCode;
  int shopOwnerMobileNumber;
  String shopOwnerEmail;
  int selectedCountryId;
  String countryName;
  int selectedStateId;
  String stateName;
  int selectedCityId;
  String cityName;
  int selectedAreaId;
  String areaName;
  String shopAddress;
  int shopPincode;

  ShopDetails({
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
}

class State {
  int id;
  String stateName;

  State({
    required this.id,
    required this.stateName,
  });
}
