class CustomerViewShopReqModel {
  String? shopId;

  CustomerViewShopReqModel({
    this.shopId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["shop_id"] = shopId;
    return data;
  }
}

///////////////////Response/////////////////
class CustomerViewShopResModel {
  int? status;
  String? message;
  ShopData? data;

  CustomerViewShopResModel({
    required this.status,
    required this.message,
    required this.data,
  });
  CustomerViewShopResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json['data'] != null ? ShopData.fromJson(json['data']) : null;
  }
}

class OfferProduct {
  int? id;
  String? productName;
  String? productImagePath;
  String? productImageName;
  String? weight;
  String? offerPrice;
  int? productId;
  int? selectedProductId;
  String? status;
  String? unit;
  String? discountPercentage;
  String? mrpPrice;
  OfferProduct({
    this.status,
    this.id,
    this.productId,
    this.selectedProductId,
    this.offerPrice,
    this.productImagePath,
    this.productName,
    this.unit,
    this.productImageName,
    this.weight,
    this.mrpPrice,
    this.discountPercentage,
  });
  OfferProduct.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productId = json["product_id"];
    selectedProductId = json["selected_product_id"];
    offerPrice = json["offer_price"];
    productImageName = json["product_image_name"];
    productImagePath = json["product_image_path"];
    productName = json["product_name"];
    weight = json["weight"];
    status = json["status"];
    unit = json["unit"];
    mrpPrice = json["mrp_price"];
    discountPercentage = json["discount_percentage"];
  }
}

class SeasonalProduct {
  int? id;
  String? productName;
  String? productImagePath;
  String? productImageName;
  String? weight;
  String? offerPrice;
  int? productId;
  int? selectedProductId;
  String? status;
  String? unit;
  String? discountPercentage;
  String? mrpPrice;
  SeasonalProduct({
    this.status,
    this.id,
    this.productId,
    this.selectedProductId,
    this.offerPrice,
    this.productImagePath,
    this.productName,
    this.unit,
    this.productImageName,
    this.weight,
    this.mrpPrice,
    this.discountPercentage,
  });
  SeasonalProduct.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productId = json["product_id"];
    selectedProductId = json["selected_product_id"];
    offerPrice = json["offer_price"];
    productImageName = json["product_image_name"];
    productImagePath = json["product_image_path"];
    productName = json["product_name"];
    weight = json["weight"];
    status = json["status"];
    unit = json["unit"];
    mrpPrice = json["mrp_price"];
    discountPercentage = json["discount_percentage"];
  }
}

class RecommandedProducts {
  int? id;
  String? productName;
  String? productImagePath;
  String? productImageName;
  String? weight;
  String? offerPrice;
  String? mrpPrice;
  String? discountPercentage;
  int? productId;
  int? selectedProductId;
  String? status;
  String? unit;
  RecommandedProducts(
      {this.status,
      this.id,
      this.productId,
      this.selectedProductId,
      this.offerPrice,
      this.productImagePath,
      this.productName,
      this.unit,
      this.productImageName,
      this.weight,
      this.mrpPrice,
      this.discountPercentage});
  RecommandedProducts.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productId = json["product_id"];
    selectedProductId = json["selected_product_id"];
    offerPrice = json["offer_price"];
    productImageName = json["product_image_name"];
    productImagePath = json["product_image_path"];
    productName = json["product_name"];
    weight = json["weight"];
    mrpPrice = json["mrp_price"];
    discountPercentage = json["discount_percentage"];
    status = json["status"];
    unit = json["unit"];
  }
}

class ShopData {
  ShopDetails? shopDetails;
  List<ShopCategory>? shopCategories;
  List<OfferProduct>? offerProduct;
  List<SeasonalProduct>? seasonalProduct;
  List<RecommandedProducts>? recommandedProduct;

  ShopData({
    required this.shopDetails,
    required this.shopCategories,
    required this.offerProduct,
    required this.seasonalProduct,
    required this.recommandedProduct,
  });
  ShopData.fromJson(Map<String, dynamic> json) {
    shopDetails = json['shop_details'] != null
        ? ShopDetails.fromJson(json['shop_details'])
        : null;
    if (json["shop_categories"] != null) {
      shopCategories = <ShopCategory>[];
      json["shop_categories"].forEach((v) {
        shopCategories!.add(ShopCategory.fromJson(v));
      });
    }
    if (json["offer_products"] != null) {
      offerProduct = <OfferProduct>[];
      json["offer_products"].forEach((v) {
        offerProduct!.add(OfferProduct.fromJson(v));
      });
    }
    if (json["seasonal_products"] != null) {
      seasonalProduct = <SeasonalProduct>[];
      json["seasonal_products"].forEach((v) {
        seasonalProduct!.add(SeasonalProduct.fromJson(v));
      });
    }
    if (json["recommanded_products"] != null) {
      recommandedProduct = <RecommandedProducts>[];
      json["recommanded_products"].forEach((v) {
        recommandedProduct!.add(RecommandedProducts.fromJson(v));
      });
    }
  }
}

class ShopCategory {
  int? id;
  String? categoryName;
  String? categoryImagePath;
  String? categoryImageName;
  int? categorySequence;

  ShopCategory({
    required this.id,
    required this.categoryName,
    required this.categoryImagePath,
    required this.categoryImageName,
    required this.categorySequence,
  });
  ShopCategory.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    categoryName = json["category_name"];
    categoryImagePath = json["category_image_path"];
    categoryImageName = json["category_image_name"];
    categorySequence = json["category_sequence"];
  }
}

class ShopDetails {
  int? id;
  String? shopName;
  String? cityName;
  String? areaName;
  int? shopPincode;
  String? shopAddress;
  String? shopOwnerSupportNumber;
  String? shopOwnerShopOpeningTime;
  String? shopOwnerShopCloseTime;
  String? shopOpenStatus;
  String? shopFavourite;

  ShopDetails({
    required this.id,
    required this.shopName,
    required this.cityName,
    required this.areaName,
    required this.shopPincode,
    required this.shopAddress,
    required this.shopOwnerSupportNumber,
    required this.shopOwnerShopOpeningTime,
    required this.shopOwnerShopCloseTime,
    required this.shopOpenStatus,
    required this.shopFavourite,
  });
  ShopDetails.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    shopName = json["shop_name"];
    cityName = json["city_name"];
    areaName = json["area_name"];
    shopPincode = json["shop_pincode"];
    shopAddress = json["shop_address"];
    shopOwnerSupportNumber = json["shop_owner_support_number"];
    shopOwnerShopOpeningTime = json["shop_owner_shop_opening_time"];
    shopOwnerShopCloseTime = json["shop_owner_shop_close_time"];
    shopOpenStatus = json["shop_open_status"];
    shopFavourite = json["is_favourite"];
  }
}
