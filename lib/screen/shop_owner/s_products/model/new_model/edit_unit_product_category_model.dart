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
  List<Unit>? units;

  EditProductUnitCategoryResModel({
    required this.status,
    required this.message,
    required this.editunitdata,
    required this.units,
  });
  EditProductUnitCategoryResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    editunitdata =
        json['data'] != null ? EditUnitData.fromJson(json['data']) : null;
    if (json["units"] != null) {
      units = <Unit>[];
      json["units"].forEach((v) {
        units!.add(Unit.fromJson(v));
      });
    }
  }
}

class EditUnitData {
  ProductUnitDetails? productUnitDetails;

  EditUnitData({
    required this.productUnitDetails,
  });
  EditUnitData.fromJson(Map<String, dynamic> json) {
    productUnitDetails = json['product_unit_details'] != null
        ? ProductUnitDetails.fromJson(json['product_unit_details'])
        : null;
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
