class ShopUpdateProfileReqModel {
  String? shopName;
  String? shopOwnerName;
  String? shopOwnerCountryCode;
  String? shopOwnerMobileNumber;
  String? shopOwnerEmail;
  String? selectedCountryId;

  String? selectedStateId;

  String? selectedCityId;

  String? selectedAreaId;

  String? shopAddress;
  String? shopPincode;
  String? shopBannerSequence;
  String? bannerNotToBeDeletedIds;

  ShopUpdateProfileReqModel({
    this.selectedAreaId,
    this.selectedCityId,
    this.selectedCountryId,
    this.selectedStateId,
    this.shopAddress,
    this.shopName,
    this.shopOwnerCountryCode,
    this.shopOwnerEmail,
    this.shopOwnerMobileNumber,
    this.shopOwnerName,
    this.shopPincode,
    this.shopBannerSequence,
    this.bannerNotToBeDeletedIds,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["shop_name"] = shopName;
    data["shop_owner_name"] = shopOwnerName;
    data["shop_owner_country_code"] = shopOwnerCountryCode;
    data["shop_owner_mobile_number"] = shopOwnerMobileNumber;
    data["shop_owner_email"] = shopOwnerEmail;
    data["shop_country_id"] = selectedCountryId;
    data["shop_state_id"] = selectedStateId;
    data["shop_city_id"] = selectedCityId;
    data["shop_area_id"] = selectedAreaId;
    data["shop_address"] = shopAddress;
    data["shop_pincode"] = shopPincode;
    data["shop_banner_sequence"] = shopBannerSequence;
    data["banner_not_to_be_deleted_ids"] = bannerNotToBeDeletedIds;
    return data;
  }
}

//response model

class ShopUpdateProfileResModel {
  int? status;
  String? message;

  ShopUpdateProfileResModel({
    required this.status,
    required this.message,
  });

  ShopUpdateProfileResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
