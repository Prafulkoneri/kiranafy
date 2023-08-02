class PlaceAdBannerModel {
  int? status;
  String? message;
  CPlaceAd? cplacead;

  PlaceAdBannerModel({
    required this.status,
    required this.message,
    required this.cplacead,
  });
  PlaceAdBannerModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    cplacead =
    json['data'] != null ? CPlaceAd.fromJson(json['data']) : null;
  }

}

class CPlaceAd {
  List<CustomerPlaceAd>? customerplacead;

  CPlaceAd({
    required this.customerplacead,
  });
  CPlaceAd.fromJson(Map<String, dynamic> json) {
    if (json["shop_enquiries_details"] != null) {
      customerplacead = <CustomerPlaceAd>[];
      json["shop_enquiries_details"].forEach((v) {
        customerplacead!.add(CustomerPlaceAd.fromJson(v));
      });
    }
  }

}

class CustomerPlaceAd {
  String? shopBannerImagePath;
  String? shopBannerImageName;

  CustomerPlaceAd({
    required this.shopBannerImagePath,
    required this.shopBannerImageName,
  });
  CustomerPlaceAd.fromJson(Map<String, dynamic> json) {
    shopBannerImagePath = json["shop_banner_image_path"];
    shopBannerImageName = json["shop_banner_image_name"];

  }

}
