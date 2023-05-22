class BannerAds {
  int? status;
  String? message;
  List<Data>? data;

  BannerAds({
    required this.status,
    required this.message,
    required this.data,
  });
  BannerAds.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];

    if (json["data"] != null) {
      data = <Data>[];
      json["data"].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  String? userType;
  String? fromDate;
  String? toDate;
  int? advertisementSequence;
  String? advertisementUrl;
  String? redirectToProduct;
  String? bannerImagePath;
  String? bannerImageName;
  String? status;

  Data({
    required this.userType,
    required this.fromDate,
    required this.toDate,
    required this.advertisementSequence,
    required this.advertisementUrl,
    required this.redirectToProduct,
    required this.bannerImagePath,
    required this.bannerImageName,
    required this.status,
  });
  Data.fromJson(Map<String, dynamic> json) {
    userType = json["user_type"];
    fromDate = json["from_date"];
    toDate = json["to_date"];
    advertisementSequence = json["advertisement_sequence"];
    advertisementUrl = json["advertisement_url"];
    redirectToProduct = json["redirect_to_product"];
    bannerImagePath = json["banner_image_path"];
    bannerImageName = json["banner_image_name"];
    status = json["status"];
  }
}
