////Request Model
class ShopAddProductsListRequestModel {
  String? category_id;
  String ? limit;
  String ? offset;

  ShopAddProductsListRequestModel({
    this.category_id,
    this.offset,
    this.limit,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["category_id"] = category_id;
    data["limit"] = limit;
    data["offset"] = offset;
    return data;
  }
}

////Response Model
class ShopAddProductsListResponse {
  int? status;
  String? message;
  Data? data;

  ShopAddProductsListResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  ShopAddProductsListResponse.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];

    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? categoryName;
  int? allProductsCount;
  int ? selectedProductCount;
  List<ProductDetail>? productDetails;
  List<SelectedProductIdData>? selectedProductIdData;

  Data({
    required this.allProductsCount,
    this.categoryName,
    required this.productDetails,
    this.selectedProductCount,
    this.selectedProductIdData
  });

  Data.fromJson(Map<String, dynamic> json) {
    categoryName = json["category_name"];
    allProductsCount = json['all_products_count'];
    selectedProductCount = json['selected_products_count'];
    // selectedProductIdData = json['selected_products_id'];
    // productDetails = json['product_details'];

    if (json["product_details"] != null) {
      productDetails = <ProductDetail>[];
      json["product_details"].forEach((v) {
        productDetails!.add(ProductDetail.fromJson(v));
      });
    }  if (json["selected_products_id"] != null) {
      selectedProductIdData = <SelectedProductIdData>[];
      json["selected_products_id"].forEach((v) {
        selectedProductIdData!.add(SelectedProductIdData.fromJson(v));
      });
    }
  }
}

class ProductDetail {
  int? id;
  String? productName;
  String? productImagePath;
  String? selectedByShopOwner;
  String? unitWithWeight;
  int ? selectedProductCount;

  ProductDetail({
    required this.id,
    required this.productName,
    required this.productImagePath,
    required this.selectedByShopOwner,
    required this.unitWithWeight,
    required this.selectedProductCount,
  });

  ProductDetail.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productName = json["product_name"];
    productImagePath = json["product_image_path"];
    selectedByShopOwner = json["selected_by_shop_owner"];
    selectedProductCount = json["selected_products_count"];
    unitWithWeight = json["unit_with_weight"];
  }
}

class SelectedProductIdData{
  int ? selectedProductId;
  SelectedProductIdData({
    this.selectedProductId,
});
  SelectedProductIdData.fromJson(Map<String,dynamic>json){
    selectedProductId=json["product_id"];
  }
}
