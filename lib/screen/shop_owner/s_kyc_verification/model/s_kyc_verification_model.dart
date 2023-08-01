class ShopKycVerificationReqModel {
  String? aadharCardImgPath;
  String? panCardImgPath;
  String? gstImgPath;
  String? shopOwnerShopActImgPath;
  String? aadharCardNo;
  String? panCardNo;
  String? gstNo;

  ShopKycVerificationReqModel({
    this.aadharCardImgPath,
    this.aadharCardNo,
    this.gstImgPath,
    this.gstNo,
    this.panCardImgPath,
    this.panCardNo,
    this.shopOwnerShopActImgPath,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data["shop_owner_aadhar_card_image_path"] = aadharCardImgPath;
    data["shop_owner_pan_card_image_path"] = aadharCardImgPath;
    data["shop_owner_shop_act_image_path"] = shopOwnerShopActImgPath;
    data["shop_owner_gst_image_path"] = gstImgPath;
    data["shop_owner_gst_image_path"] = gstImgPath;
    data["shop_owner_gst_no"] = gstNo;
    data["shop_owner_aadhar_card_no"] = aadharCardNo;
    data["shop_owner_pan_card_no"] = panCardNo;

    return data;
  }
}

class ShopKycVerificationResModel {
  String? status;
  String? message;
  String? subscriptonStatus;

  ShopKycVerificationResModel({
    this.message,
    this.status,
    this.subscriptonStatus,
  });

  ShopKycVerificationResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    subscriptonStatus = json["subscription_status"];
  }
}
