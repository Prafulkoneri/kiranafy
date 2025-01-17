import 'package:local_supper_market/screen/shop_owner/s_products/model/custom_product_data_model.dart';

///REquest Model

class EditCustomProductsRequestModel {
  String? product_id;

  EditCustomProductsRequestModel({
    this.product_id,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["product_id"] = product_id;
    return data;
  }
}

///////////Reponse_model
class EditCustomProductsResponseModel {
  int? status;
  String? message;
  Data? data;


  EditCustomProductsResponseModel({
    required this.status,
    required this.message,
    required this.data,

  });

  EditCustomProductsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];

    data = json['data'] != null ? Data.fromJson(json['data']) : null;

  }
}

class Data {
  ProductDetails? productDetails;
  List<CategoryData>? categoryData;
  List<BrandData>? brandData;
  List<TaxData>? taxData;
  List<UnitData>? unitData;

  Data({
    this.productDetails,
    this.unitData,
    this.taxData,
    this.brandData,
    this.categoryData,
  });

  Data.fromJson(Map<String, dynamic> json) {
    productDetails = json['product_details'] != null
        ? ProductDetails.fromJson(json['product_details'])
        : null;
    if (json["category_data"] != null) {
      categoryData = <CategoryData>[];
      json["category_data"].forEach((v) {
        categoryData!.add(CategoryData.fromJson(v));
      });
    }
    if (json["brand_data"] != null) {
      brandData = <BrandData>[];
      json["brand_data"].forEach((v) {
        brandData!.add(BrandData.fromJson(v));
      });
    }
    if (json["tax_data"] != null) {
      taxData = <TaxData>[];
      json["tax_data"].forEach((v) {
        taxData!.add(TaxData.fromJson(v));
      });
    }
    if (json["unit_data"] != null) {
      unitData = <UnitData>[];
      json["unit_data"].forEach((v) {
        unitData!.add(UnitData.fromJson(v));
      });
    }
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
  }
}




