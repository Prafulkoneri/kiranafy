class DashBoardModel {
  int? status;
  String? message;
  Data? data;

  DashBoardModel({
    required this.status,
    required this.message,
    required this.data,
  });

  DashBoardModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    // data = json['data'] != null ? Data.fromJson(json['data']) : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? categoriesCount;
  int? productsCount;
  List<BannerImageData>? bannerImages;

  Data({
    required this.categoriesCount,
    required this.productsCount,
    required this.bannerImages,
  });

  Data.fromJson(Map<String, dynamic> json) {
    categoriesCount = json["categories_count"];
    productsCount = json["products_count"];
    if (json["shop_banner_images"] != null) {
      bannerImages = <BannerImageData>[];
      json["shop_banner_images"].forEach((v) {
        bannerImages!.add(BannerImageData.fromJson(v));
      });
    }
  }
}

class BannerImageData {
  String? imagesPath;
  String? imageName;

  BannerImageData({
    this.imageName,
    this.imagesPath,
  });

  BannerImageData.fromJson(Map<String, dynamic> json) {
    imagesPath = json["shop_banner_image_path"];
    imageName = json["shop_banner_image_name"];
  }
}
