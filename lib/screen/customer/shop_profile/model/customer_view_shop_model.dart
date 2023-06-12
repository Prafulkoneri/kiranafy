import 'package:local_supper_market/screen/shop_owner/s_dashboard/model/dash_board_model.dart';

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
  String? mrpPrice;
  int? productId;
  int? categoryId;
  String? productType;
  int? selectedProductId;
  String? discountPercentage;
  String? status;
  String? unit;

  OfferProduct({
    this.categoryId, //
    this.status,
    this.id, //
    this.productId, //
    this.selectedProductId, //
    this.offerPrice, //
    this.productImagePath, //
    this.productName, //
    this.unit,
    this.productImageName, //
    this.weight, //
    this.mrpPrice, //
    this.discountPercentage, //
    this.productType, //
  });
  OfferProduct.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productName = json["product_name"];
    productImagePath = json["product_image_path"];
    productImageName = json["product_image_name"];
    weight = json["weight"];
    offerPrice = json["offer_price"];
    mrpPrice = json["mrp_price"];
    categoryId = json["category_id"];
    productType = json["product_type"];
    selectedProductId = json["selected_product_id"];
    discountPercentage = json["discount_percentage"];
    productId = json["product_id"];
    status = json["status"];
    unit = json["unit"];
  }
}

class SeasonalProduct {
  int? id;
  String? productName;
  String? productImagePath;
  String? productImageName;
  String? weight;
  String? offerPrice;
  String? mrpPrice;
  int? productId;
  int? categoryId;
  String? productType;
  int? selectedProductId;
  String? discountPercentage;
  String? status;
  String? unit;
  SeasonalProduct({
    this.categoryId, //
    this.status,
    this.id, //
    this.productId, //
    this.selectedProductId, //
    this.offerPrice, //
    this.productImagePath, //
    this.productName, //
    this.unit,
    this.productImageName, //
    this.weight, //
    this.mrpPrice, //
    this.discountPercentage, //
    this.productType, //
  });
  SeasonalProduct.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productName = json["product_name"];
    productImagePath = json["product_image_path"];
    productImageName = json["product_image_name"];
    weight = json["weight"];
    offerPrice = json["offer_price"];
    mrpPrice = json["mrp_price"];
    categoryId = json["category_id"];
    productType = json["product_type"];
    selectedProductId = json["selected_product_id"];
    discountPercentage = json["discount_percentage"];
    productId = json["product_id"];
    status = json["status"];
    unit = json["unit"];
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
  int? productId;
  int? categoryId;
  String? productType;
  int? selectedProductId;
  String? discountPercentage;
  String? status;
  String? unit;
  RecommandedProducts({
    this.categoryId,
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
    this.productType,
    this.discountPercentage,
  });
  RecommandedProducts.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productName = json["product_name"];
    productImagePath = json["product_image_path"];
    productImageName = json["product_image_name"];
    weight = json["weight"];
    offerPrice = json["offer_price"];
    mrpPrice = json["mrp_price"];
    categoryId = json["category_id"];
    productType = json["product_type"];
    selectedProductId = json["selected_product_id"];
    discountPercentage = json["discount_percentage"];
    productId = json["product_id"];
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
  List<BannerImageData>? bannerImages;

  ShopData({
    required this.shopDetails,
    required this.shopCategories,
    required this.offerProduct,
    required this.seasonalProduct,
    required this.recommandedProduct,
    required this.bannerImages,
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
    if (json["shop_banner_images"] != null) {
      bannerImages = <BannerImageData>[];
      json["shop_banner_images"].forEach((v) {
        bannerImages!.add(BannerImageData.fromJson(v));
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
