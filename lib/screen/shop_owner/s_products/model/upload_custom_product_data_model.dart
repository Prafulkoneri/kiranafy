class UploadCustomProductReqModel {
  String? productName;
  String? categoryId;
  String? brandId;
  String? taxId;
  String? productDescription;
  String? totalRows;
  String? showUnderSeasonalProduct;
  String? showUnderRecommendedProduct;
  String? showUnderFullfillCravings;
  String? productImagePath;


  UploadCustomProductReqModel(
      {
      this.categoryId,
      this.brandId,

      this.productDescription,
      this.productImagePath,
      this.productName,
      this.showUnderFullfillCravings,
      this.showUnderRecommendedProduct,
      this.showUnderSeasonalProduct,
      this.taxId,
      });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["product_name"] = productName;
    data["category_id"] = categoryId;
    data["brand_id"] = brandId;
    data["tax_id"] = taxId;
    data["product_description"] = productDescription;
    data["show_under_seasonal_products"] = showUnderSeasonalProduct;
    data["show_under_recommanded_products"] = showUnderRecommendedProduct;
    data["show_under_fullfill_your_cravings"] = showUnderFullfillCravings;
    return data;
  }
}

class UploadCustomProductResModel {
  int? status;
  String? message;

  UploadCustomProductResModel({
    this.status,
    this.message,
  });

  UploadCustomProductResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
