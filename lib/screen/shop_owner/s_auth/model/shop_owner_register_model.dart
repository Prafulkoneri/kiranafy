import 'package:local_supper_market/screen/shop_owner/s_auth/model/login_model.dart';

class ShopOwnerRegisterReqModel {
  String? shopName;
  String? shopOwnerName;
  String? countryCode;
  String? mobileNo;
  String? email;
  String? shopType;
  String? countryId;
  String? stateId;
  String? cityId;
  String? areaId;
  String? shopAddress;
  String ? pincode;
  String? shopPincode;
  String? shopUpiId;
  String? fcmToken;

  ShopOwnerRegisterReqModel({
    this.areaId,
    this.cityId,
    this.stateId,
    this.countryId,
    this.countryCode,
    this.mobileNo,
    this.email,
    this.shopAddress,
    this.shopName,
    this.shopOwnerName,
    this.shopPincode,
    this.shopType,
    this.shopUpiId,
    this.fcmToken,
    this.pincode,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["shop_name"] = shopName;
    data["shop_owner_name"] = shopOwnerName;
    data["shop_owner_country_code"] = countryCode;
    data["shop_owner_mobile_number"] = mobileNo;
    data["shop_owner_email"] = email;
    data["shop_type"] = shopType;
    data["shop_country_id"] = countryId;
    data["shop_state_id"] = stateId;
    data["shop_city_id"] = cityId;
    data["shop_area_id"] = areaId;
    data["shop_address"] = shopAddress;
    data["shop_pincode"] = shopPincode;
    data["shop_owner_upi_id"] = shopUpiId;
    data["shop_owner_fcm_token"] = fcmToken;
    data["shop_pincode"]=pincode;
    return data;
  }
}

class ShopOwnerRegisterResModel {
  int? status;
  String? message;
  SuccessToken? successToken;
  String? kycStatus;

  ShopOwnerRegisterResModel({
    this.status,
    this.successToken,
    this.message,
    this.kycStatus,
  });

  ShopOwnerRegisterResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    successToken = json['success_token'] != null ? SuccessToken.fromJson(json['success_token']) : null;
    kycStatus = json["kyc_status"];
  }
}
