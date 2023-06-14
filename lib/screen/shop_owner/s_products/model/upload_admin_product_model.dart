class UploadAdminProductReqModel {
  String? productId;
  String? showUnderSeasonalProduct;
  String? showUnderRecommendedProduct;
  String? showUnderFullfillCravings;
  String? totalRows;
  String? unitID;
  String? weight;
  String? mrpPrice;
  String? offerPrice;
  String? status;
  String? unitBasedProductImage1;
  String? unitBasedProductImage2;
  String? unitBasedProductImage3;

  UploadAdminProductReqModel(
      {this.productId,
      this.status,
      this.mrpPrice,
      this.offerPrice,
      this.showUnderFullfillCravings,
      this.showUnderRecommendedProduct,
      this.showUnderSeasonalProduct,
      this.totalRows,
      this.unitBasedProductImage1,
      this.unitBasedProductImage2,
      this.unitBasedProductImage3,
      this.unitID,
      this.weight});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["total_rows"] = totalRows;
    data["product_id"] = productId;
    data["show_under_seasonal_products"] = showUnderSeasonalProduct;
    data["show_under_recommanded_products"] = showUnderRecommendedProduct;
    data["show_under_fullfill_your_cravings"] = showUnderFullfillCravings;
    data["unit_ids"] = unitID;
    data["weight_ids"] = weight;
    data["mrp_price_ids"] = mrpPrice;
    data["offer_price_ids"] = offerPrice;
    data["status_ids"] = status;
    // data["unit_based_product_image_1_path_0"]=unitBasedProductImage1;
    // data["unit_based_product_image_2_path_0"]=unitBasedProductImage2;
    // data["unit_based_product_image_3_path_0"]=unitBasedProductImage3;
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
