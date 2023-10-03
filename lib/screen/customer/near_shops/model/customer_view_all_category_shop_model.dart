import 'package:local_supper_market/screen/customer/near_shops/model/customer_view_all_shop_model.dart';

class CustomerViewAllCategoryShopReqModel {
  String? limit;
  String? offset;
  String? categoryId;
  String? areaId;
  String? rating;
  CustomerViewAllCategoryShopReqModel({
    this.limit,
    this.offset,
    this.categoryId,
    required this.areaId,
    required this.rating,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data["limit"] = limit;
    data["offset"] = offset;
    data["category_id"] = categoryId;
    data["area_id"] = areaId;
    data["rating"] = rating;
    return data;
  }
}

class CustomerViewAllCategoryShopResModel {
  int? status;
  String? message;
  Data? data;

  CustomerViewAllCategoryShopResModel({
    this.status,
    this.data,
    this.message,
  });
  CustomerViewAllCategoryShopResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}
