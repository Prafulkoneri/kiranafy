import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';

class AllSeasonalProductsReqModel {
  String? shopId;
  String? limit;
  String? offset;

  AllSeasonalProductsReqModel({this.shopId, this.limit, this.offset});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["shop_id"] = shopId;
    data["limit"] = limit;
    data["offset"] = offset;
    return data;
  }
}

////////////////RES

class ViewAllSeasonalProducts {
  int? status;
  String? message;
  Data? data;

  ViewAllSeasonalProducts({
    required this.status,
    required this.message,
    required this.data,
  });
  ViewAllSeasonalProducts.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<CustomerProductData>? seasonalProducts;

  Data({
    required this.seasonalProducts,
  });
  Data.fromJson(Map<String, dynamic> json) {
    if (json["seasonal_products"] != null) {
      seasonalProducts = <CustomerProductData>[];
      json["seasonal_products"].forEach((v) {
        seasonalProducts!.add(CustomerProductData.fromJson(v));
      });
    }
  }
}


