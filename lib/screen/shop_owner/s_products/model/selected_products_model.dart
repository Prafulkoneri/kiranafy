///Request Model///

class SelecteProductsRequestModel {
  String? category_id;
  SelecteProductsRequestModel({
    this.category_id,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["category_id"] = category_id;

    return data;
  }
}

///////ResponseModel//////
class GetSelectedProductsResponseModel {
  int? status;
  String? message;
  Data? data;

  GetSelectedProductsResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });
  GetSelectedProductsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<ProductsFromAdmin>? productsFromAdmin;
  int? totalSelectedAndCustomProducts;

  Data({
    required this.productsFromAdmin,
    required this.totalSelectedAndCustomProducts,
  });
  Data.fromJson(Map<String, dynamic> json) {
    if (json["products_from_admin"] != null) {
      productsFromAdmin = <ProductsFromAdmin>[];
      json["products_from_admin"].forEach((v) {
        productsFromAdmin!.add(ProductsFromAdmin.fromJson(v));
      });
    }
    totalSelectedAndCustomProducts = json['total_selected_and_custom_products'];
  }
}

class ProductsFromAdmin {
  int? id;
  String? productName;
  String? productType;
  String? productImagePath;
  List<UnitDetail>? unitDetails;

  ProductsFromAdmin({
    required this.id,
    required this.productName,
    required this.productType,
    required this.productImagePath,
    required this.unitDetails,
  });
  ProductsFromAdmin.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productName = json["product_name"];
    productType = json["product_type"];
    productImagePath = json['product_image_path'];

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
