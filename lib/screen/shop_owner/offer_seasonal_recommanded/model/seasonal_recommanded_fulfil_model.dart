class RecommandedSeasonalFulFilModel {
  int? status;
  String? message;
  AllProductsData? allproducts;

  RecommandedSeasonalFulFilModel({
    required this.status,
    required this.message,
    required this.allproducts,
  });
  RecommandedSeasonalFulFilModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    allproducts =
        json['data'] != null ? AllProductsData.fromJson(json['data']) : null;
  }
}

class AllProductsData {
  List<Product>? recommendedProducts;
  List<Product>? seasonalProducts;
  List<Product>? fullfillYourCravingsProducts;

  AllProductsData({
    required this.recommendedProducts,
    required this.seasonalProducts,
    required this.fullfillYourCravingsProducts,
  });
  AllProductsData.fromJson(Map<String, dynamic> json) {
    if (json["recommended_products"] != null) {
      recommendedProducts = <Product>[];
      json["recommended_products"].forEach((v) {
        recommendedProducts!.add(Product.fromJson(v));
      });
    }
    if (json["seasonal_products"] != null) {
      seasonalProducts = <Product>[];
      json["seasonal_products"].forEach((v) {
        seasonalProducts!.add(Product.fromJson(v));
      });
    }
    if (json["fullfill_your_cravings_products"] != null) {
      fullfillYourCravingsProducts = <Product>[];
      json["fullfill_your_cravings_products"].forEach((v) {
        fullfillYourCravingsProducts!.add(Product.fromJson(v));
      });
    }
  }
}

class Product {
  int? id;
  String? productName;
  String? productType;
  String? productImagePath;
  List<UnitDetail>? unitDetails;

  Product({
    required this.id,
    required this.productName,
    required this.productType,
    required this.productImagePath,
    this.unitDetails,
  });
  Product.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productName = json["product_name"];
    productType = json["product_type"];
    productImagePath = json["product_image_path"];
    if (json["unit_details"] != null) {
      unitDetails = <UnitDetail>[];
      json["unit_details"].forEach((v) {
        unitDetails!.add(UnitDetail.fromJson(v));
      });
    }
  }
}

class UnitDetail {
  String? weightAndUnit;
  int? offerPrice;
  int? mrpPrice;

  UnitDetail({
    required this.weightAndUnit,
    required this.offerPrice,
    required this.mrpPrice,
  });
  UnitDetail.fromJson(Map<String, dynamic> json) {
    weightAndUnit = json["weight_and_unit"];
    offerPrice = json["offer_price"];
    mrpPrice = json["mrp_price"];
  }
}
