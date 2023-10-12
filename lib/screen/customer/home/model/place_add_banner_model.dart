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
    cplacead = json['data'] != null ? CPlaceAd.fromJson(json['data']) : null;
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
  String? userType;
  String? fromDate;
  String? toDate;
  int? advertisementSequence;
  String? advertisementUrl;
  String? redirectToProduct;
  String? redirectToShop;
  String? shopBannerImagePath;
  String? shopBannerImageName;
  String? status;
  int? categoryId;
  int? productId;
  int? shopId;
  String? productType;

  CustomerPlaceAd({
    required this.userType,
    required this.fromDate,
    required this.toDate,
    required this.advertisementSequence,
    required this.advertisementUrl,
    required this.redirectToProduct,
    required this.shopBannerImagePath,
    required this.shopBannerImageName,
    required this.status,
    required this.categoryId,
    required this.productId,
    required this.shopId,
    required this.productType,
    required this.redirectToShop,
  });
  CustomerPlaceAd.fromJson(Map<String, dynamic> json) {
    userType = json["user_type"];
    fromDate = json["from_date"];
    toDate = json["to_date"];
    advertisementSequence = json["advertisement_sequence"];
    advertisementUrl = json["advertisement_url"];
    redirectToProduct = json["redirect_to_product"];
    shopBannerImagePath = json["banner_image_path"];
    shopBannerImageName = json["banner_image_name"];
    status = json["status"];
    categoryId = json["category_id"];
    productId = json["product_id"];
    shopId = json["shop_id"];
    productType = json["type_of_product"];
    redirectToShop = json["redirect_to_shop"];
  }
}
