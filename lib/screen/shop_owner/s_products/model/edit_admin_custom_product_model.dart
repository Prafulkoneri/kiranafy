class EditAdminProductReqModel {
  String? product_id;

  EditAdminProductReqModel({this.product_id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["product_id"] = product_id;
    return data;
  }
}

class EditAdminProductResModel {
  int? status;
  String? message;
  AdminData? data;
  List<Unit>? units;

  EditAdminProductResModel({
    required this.status,
    required this.message,
    required this.data,
    required this.units,
  });

  EditAdminProductResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json['data'] != null ? AdminData.fromJson(json['data']) : null;
    if (json["units"] != null) {
      units = <Unit>[];
      json["units"].forEach((v) {
        units!.add(Unit.fromJson(v));
      });
    }
  }
}

class AdminData {
  ProductDetails? productDetails;

  AdminData({
    required this.productDetails,
  });

  AdminData.fromJson(Map<String, dynamic> json) {
    productDetails = json['product_details'] != null
        ? ProductDetails.fromJson(json['product_details'])
        : null;
  }
}

class ProductDetails {
  int? productId;
  int? categoryId;
  String? categoryName;
  String? productName;
  int? brandId;
  String? brandName;
  int? taxId;
  String? igstTax;
  String? showUnderSeasonalProducts;
  String? showUnderRecommandedProducts;
  String? showUnderFullfillYourCravings;
  String? productDescription;
  String? productImagePath;
  String? productImageName;
  List<ProductUnitDetail>? productUnitDetails;

  ProductDetails({
    required this.productId,
    required this.categoryId,
    required this.categoryName,
    required this.productName,
    required this.brandId,
    required this.brandName,
    required this.taxId,
    required this.igstTax,
    required this.showUnderSeasonalProducts,
    required this.showUnderRecommandedProducts,
    required this.showUnderFullfillYourCravings,
    required this.productDescription,
    required this.productImagePath,
    required this.productImageName,
    required this.productUnitDetails,
  });

  ProductDetails.fromJson(Map<String, dynamic> json) {
    productId = json["product_id"];
    categoryId = json["category_id"];
    categoryName = json["category_name"];
    productName = json["product_name"];
    brandId = json["brand_id"];
    brandName = json["brand_name"];
    taxId = json["tax_id"];
    igstTax = json["igst_tax"];
    showUnderSeasonalProducts = json["show_under_seasonal_products"];
    showUnderRecommandedProducts = json["show_under_recommanded_products"];
    showUnderFullfillYourCravings = json["show_under_fullfill_your_cravings"];
    productDescription = json["product_description"];
    productImagePath = json["product_image_path"];
    productImageName = json["product_image_name"];
    if (json["product_unit_details"] != null) {
      productUnitDetails = <ProductUnitDetail>[];
      json["product_unit_details"].forEach((v) {
        productUnitDetails!.add(ProductUnitDetail.fromJson(v));
      });
    }
  }
}

class ProductUnitDetail {
  int? particularUnitId;
  int? unitId;
  String? unit;
  String? weight;
  int? mrpPrice;
  int? offerPrice;
  String? status;
  String? unitBasedProductImage1Path;
  String? unitBasedProductImage1Name;
  String? unitBasedProductImage2Path;
  String? unitBasedProductImage2Name;
  String? unitBasedProductImage3Path;
  String? unitBasedProductImage3Name;

  ProductUnitDetail({
    required this.particularUnitId,
    required this.unitId,
    required this.unit,
    required this.weight,
    required this.mrpPrice,
    required this.offerPrice,
    required this.status,
    required this.unitBasedProductImage1Path,
    required this.unitBasedProductImage1Name,
    required this.unitBasedProductImage2Path,
    required this.unitBasedProductImage2Name,
    required this.unitBasedProductImage3Path,
    required this.unitBasedProductImage3Name,
  });

  ProductUnitDetail.fromJson(Map<String, dynamic> json) {
    particularUnitId = json["particular_unit_id"];
    unitId = json["unit_id"];
    unit = json["unit"];
    weight = json["weight"];
    mrpPrice = json["mrp_price"];
    offerPrice = json["offer_price"];
    status = json["status"];
    unitBasedProductImage1Path = json["unit_based_product_image_1_path"];
    unitBasedProductImage1Name = json["unit_based_product_image_1_name"];
    unitBasedProductImage2Path = json["unit_based_product_image_2_path"];
    unitBasedProductImage2Name = json["unit_based_product_image_2_name"];
    unitBasedProductImage3Path = json["unit_based_product_image_3_path"];
    unitBasedProductImage3Name = json["unit_based_product_image_3_name"];
  }
}

class Unit {
  int? id;
  String? unit;

  Unit({
    required this.id,
    required this.unit,
  });

  Unit.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    unit = json["unit"];
  }
}
