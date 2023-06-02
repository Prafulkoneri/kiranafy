import 'package:local_supper_market/screen/customer/category/model/product_as_per_category_model.dart';

class SearchProductAsPerCategoryReqModel{
  String? shopId;
  String? categoryId;
  String ? productName;
  SearchProductAsPerCategoryReqModel({
    this.categoryId,
    this.shopId,
    this.productName
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["shop_id"] = shopId;
    data["category_id"] = categoryId;
    data["product_name"] = productName;
    return data;
  }
}

class SearchProductAsPerCategoryResModel {
  int? status;
  String? message;
  CategoryProductData? data;

  SearchProductAsPerCategoryResModel({
    required this.status,
    required this.message,
    required this.data,
  });
  SearchProductAsPerCategoryResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json['data'] != null
        ? CategoryProductData.fromJson(json['data'])
        : null;
  }
}