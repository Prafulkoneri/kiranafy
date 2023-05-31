class ProductViewRequestModel {
  String? shopId;
  String? categoryId;
  String? productId;

  ProductViewRequestModel({this.shopId, this.categoryId, this.productId});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["shop_id"] = shopId;
    data["category_id"] = categoryId;
    data["product_id"] = productId;
    return data;
  }
}

/////////////////ResModel//////////////
class ProductViewResponseModel {
  int? status;
  String? message;
  ProductViewData? data;

  ProductViewResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });
  ProductViewResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json['data'] != null ? ProductViewData.fromJson(json['data']) : null;
  }
}

class ProductViewData {
  ProductDetails? productDetails;
  List<ProductUnitDetail>? productUnitDetails;
  List<SimilarProduct>? similarProducts;

  ProductViewData({
    required this.productDetails,
    required this.productUnitDetails,
    required this.similarProducts,
  });
  ProductViewData.fromJson(Map<String, dynamic> json) {
    productDetails = json['product_details'] != null
        ? ProductDetails.fromJson(json['product_details'])
        : null;

    if (json["product_unit_details"] != null) {
      productUnitDetails = <ProductUnitDetail>[];
      json["product_unit_details"].forEach((v) {
        productUnitDetails!.add(ProductUnitDetail.fromJson(v));
      });
    }

    if (json["similar_products"] != null) {
      similarProducts = <SimilarProduct>[];
      json["similar_products"].forEach((v) {
        similarProducts!.add(SimilarProduct.fromJson(v));
      });
    }
  }
}

class ProductDetails {
  int? id;
  String? productName;
  String? productImagePath;
  String? productImageName;
  String? categoryName;
  String? brandName;
  String? productDescription;

  ProductDetails({
    required this.id,
    required this.productName,
    required this.productImagePath,
    required this.productImageName,
    required this.categoryName,
    required this.brandName,
    required this.productDescription,
  });
  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productName = json["product_name"];
    productImagePath = json["product_image_path"];
    productImageName = json["product_image_name"];
    categoryName = json["category_name"];
    brandName = json["brand_name"];
    productDescription = json["product_description"];
  }
}

class ProductUnitDetail {
  int? id;
  String? weight;
  String? offerPrice;
  String? mrpPrice;
  String? discountPercentage;
  String? unit;

  ProductUnitDetail({
    required this.id,
    required this.weight,
    required this.offerPrice,
    required this.mrpPrice,
    required this.discountPercentage,
    required this.unit,
  });
  ProductUnitDetail.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    weight = json["product_name"];
    offerPrice = json["product_image_path"];
    mrpPrice = json["product_image_name"];
    discountPercentage = json["category_name"];
    unit = json["brand_name"];
  }
}

class SimilarProduct {
  int? id;
  String? productName;
  String? productImagePath;
  String? productImageName;
  String? weight;
  String? offerPrice;
  String? mrpPrice;
  String? discountPercentage;
  String? status;
  String? unit;

  SimilarProduct({
    required this.id,
    required this.productName,
    required this.productImagePath,
    required this.productImageName,
    required this.weight,
    required this.offerPrice,
    required this.mrpPrice,
    required this.discountPercentage,
    required this.status,
    required this.unit,
  });

  SimilarProduct.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productName = json["product_name"];
    productImagePath = json["product_image_path"];
    productImageName = json["product_image_name"];
    weight = json["category_name"];
    offerPrice = json["brand_name"];
    mrpPrice = json["brand_name"];
    discountPercentage = json["brand_name"];
    status = json["brand_name"];
    unit = json["brand_name"];
  }
}
