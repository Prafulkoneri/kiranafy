import 'package:local_supper_market/screen/shop_owner/s_products/model/new_model/unit_list_to_create_product_model.dart';

class EditProductUnitCategoryRequestModel {
  String? productUnitId;
  String? productType;
  EditProductUnitCategoryRequestModel({
    this.productUnitId,
    this.productType,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["product_unit_id"] = productUnitId;
    data["product_type"] = productType;
    return data;
  }
}

////////////////////////RESPONSE MODEL////////////////////
class EditProductUnitCategoryResModel {
  int? status;
  String? message;
  EditUnitData? editunitdata;


  EditProductUnitCategoryResModel({
    required this.status,
    required this.message,
    required this.editunitdata,

  });
  EditProductUnitCategoryResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    editunitdata = json['data'] != null ? EditUnitData.fromJson(json['data']) : null;
  }
}

class EditUnitData {
  ProductUnitDetails? productUnitDetails;
  List<UnitListData>? units;

  EditUnitData({
    required this.productUnitDetails,
    required this.units,
  });
  EditUnitData.fromJson(Map<String, dynamic> json) {
    productUnitDetails = json['product_unit_details'] != null
        ? ProductUnitDetails.fromJson(json['product_unit_details'])
        : null;
    if (json["unit_data"] != null) {
      units = <UnitListData>[];
      json["unit_data"].forEach((v) {
        units!.add(UnitListData.fromJson(v));
      });
    }
  }
}

class ProductUnitDetails {
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

  ProductUnitDetails({
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
  ProductUnitDetails.fromJson(Map<String, dynamic> json) {
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

////////////////

