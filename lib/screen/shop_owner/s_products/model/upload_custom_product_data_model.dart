class UploadCustomProductReqModel {
String ? productName;
String ? categoryId;
String ? brandId;
String ? taxId;
String ? productDescription;
String ? totalRows;
String ? showUnderSeasonalProduct;
String ? showUnderRecommendedProduct;
String ? showUnderFullfillCravings;
String ? productImagePath;
String ? unitID;
String ? weight;
String ? mrpPrice;
String ? offerPrice;
String ? status;
String ? unitBasedProductImage1;
String ? unitBasedProductImage2;
String ? unitBasedProductImage3;
UploadCustomProductReqModel({
  this.status,this.categoryId,this.brandId,this.mrpPrice,this.offerPrice,this.productDescription,this.productImagePath,this.productName,this.showUnderFullfillCravings,this.showUnderRecommendedProduct,this.showUnderSeasonalProduct,this.taxId,this.totalRows,this.unitBasedProductImage1,this.unitBasedProductImage2,this.unitBasedProductImage3,this.unitID,this.weight
});
Map<String,dynamic> toJson(){
  Map<String,dynamic> data={};
  data["product_name"]=productName;
  data["category_id"]=categoryId;
  data["brand_id"]=brandId;
  data["tax_id"]=taxId;
  data["product_description"]=productDescription;
  data["total_rows"]=totalRows;
  data["show_under_seasonal_products"]=showUnderSeasonalProduct;
  data["show_under_recommanded_products"]=showUnderRecommendedProduct;
  data["show_under_fullfill_your_cravings"]=showUnderFullfillCravings;
  // data["product_image_path"]=productImagePath;
  data["unit_ids"]=unitID;
  data["weight_ids"]=weight;
  data["mrp_price_ids"]=mrpPrice;
  data["offer_price_ids"]=offerPrice;
  data["status_ids"]=status;
  // data["unit_based_product_image_1_path_0"]=unitBasedProductImage1;
  // data["unit_based_product_image_2_path_0"]=unitBasedProductImage2;
  // data["unit_based_product_image_3_path_0"]=unitBasedProductImage3;
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

  UploadCustomProductResModel.fromJson(Map<String,dynamic>json){
    status=json["status"];
    message=json["message"];
  }
}