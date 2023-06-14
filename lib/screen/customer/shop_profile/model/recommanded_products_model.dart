import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';

class RecommandedReqModel {
  String? shopId;
  String? limit;
  String? offset;

  RecommandedReqModel({this.shopId, this.limit, this.offset});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["shop_id"] = shopId;
    data["limit"] = limit;
    data["offset"] = offset;

    return data;
  }
}

/////////RES MODEL/////////////

class RecommandedResModel {
  int? status;
  String? message;
  Data? data;

  RecommandedResModel({
    required this.status,
    required this.message,
    required this.data,
  });
  RecommandedResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<CustomerProductData>? recommandedProducts;

  Data({
    required this.recommandedProducts,
  });
  Data.fromJson(Map<String, dynamic> json) {
    if (json["recommanded_products"] != null) {
      recommandedProducts = <CustomerProductData>[];
      json["recommanded_products"].forEach((v) {
        recommandedProducts!.add(CustomerProductData.fromJson(v));
      });
    }
  }
}

