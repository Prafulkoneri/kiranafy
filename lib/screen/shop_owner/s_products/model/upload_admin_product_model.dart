class UploadAdminProductReqModel {
  String? productId;
  String? showUnderSeasonalProduct;
  String? showUnderRecommendedProduct;
  String? showUnderFullfillCravings;


  UploadAdminProductReqModel(
      {this.productId,
        this.showUnderFullfillCravings,
      this.showUnderRecommendedProduct,
      this.showUnderSeasonalProduct,
      });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data["product_id"] = productId;
    data["show_under_seasonal_products"] = showUnderSeasonalProduct;
    data["show_under_recommanded_products"] = showUnderRecommendedProduct;
    data["show_under_fullfill_your_cravings"] = showUnderFullfillCravings;
    return data;
  }
}

class UploadAdminProductResModel {
  int? status;
  String? message;

  UploadAdminProductResModel({
    this.status,
    this.message,
  });

  UploadAdminProductResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
