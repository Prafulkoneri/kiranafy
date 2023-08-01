class GetProductUitListRequestModel {
  String? productId;
  String? productType;
  GetProductUitListRequestModel({
    this.productId,
    this.productType,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["product_type"] = productType;
    data["product_id"] = productId;
    return data;
  }
}

///////////////////////////////////////////RESPONSE MODEL////////////////////////////////////

class GetProductUitListResponseModel {
  int? status;
  String? message;
  GetProductUnitListData? getproductunitlistdata;

  GetProductUitListResponseModel({
    required this.status,
    required this.message,
    required this.getproductunitlistdata,
  });
  GetProductUitListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    getproductunitlistdata = json['data'] != null
        ? GetProductUnitListData.fromJson(json['data'])
        : null;
  }
}

class GetProductUnitListData {
  List<UnitDetail>? unitDetails;
  ProductDetails? productDetails;

  GetProductUnitListData({
    required this.unitDetails,
    required this.productDetails,
  });
  GetProductUnitListData.fromJson(Map<String, dynamic> json) {
    if (json["unit_details"] != null) {
      unitDetails = <UnitDetail>[];
      json["unit_details"].forEach((v) {
        unitDetails!.add(UnitDetail.fromJson(v));
      });
    }
    productDetails = json['product_details'] != null
        ? ProductDetails.fromJson(json['product_details'])
        : null;
  }
}

class ProductDetails {
  int? productId;
  String? productName;
  String? productType;

  ProductDetails({
    required this.productId,
    required this.productName,
    required this.productType,
  });
  ProductDetails.fromJson(Map<String, dynamic> json) {
    productId = json["product_id"];
    productName = json["product_name"];
    productType = json["product_type"];
  }
}

class UnitDetail {
  int? id;
  String? weightAndUnit;
  int? offerPrice;
  int? mrpPrice;
  String? status;
  String? unitBasedProductImage1Path;
  String? unitBasedProductImage1Name;

  UnitDetail({
    required this.id,
    required this.weightAndUnit,
    required this.offerPrice,
    required this.mrpPrice,
    required this.status,
    required this.unitBasedProductImage1Path,
    required this.unitBasedProductImage1Name,
  });
  UnitDetail.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    weightAndUnit = json["weight_and_unit"];
    offerPrice = json["offer_price"];
    mrpPrice = json["mrp_price"];
    status = json["status"];
    unitBasedProductImage1Path = json["unit_based_product_image_1_path"];
    unitBasedProductImage1Name = json["unit_based_product_image_1_name"];
  }
}
