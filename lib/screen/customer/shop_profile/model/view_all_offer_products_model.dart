import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';

class AllProductsReqModel {
  String? shopId;
  String? limit;
  String? offset;

  AllProductsReqModel({this.shopId, this.limit, this.offset});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["shop_id"] = shopId;
    data["limit"] = limit;
    data["offset"] = offset;

    return data;
  }
}

/////ResponseMOdel Offere Products////////////
class ViewAllOfferProducts {
  int? status;
  String? message;
  Data? data;

  ViewAllOfferProducts({
    required this.status,
    required this.message,
    required this.data,
  });
  ViewAllOfferProducts.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<CustomerProductData>? offerProducts;

  Data({
    required this.offerProducts,
  });
  Data.fromJson(Map<String, dynamic> json) {
    if (json["offer_products"] != null) {
      offerProducts = <CustomerProductData>[];
      json["offer_products"].forEach((v) {
        offerProducts!.add(CustomerProductData.fromJson(v));
      });
    }
  }
}
