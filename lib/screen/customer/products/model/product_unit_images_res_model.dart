////Request Model///////////
class UnitImagesRequestModel {
  String? slectedUnitId;
  String? productType;
  UnitImagesRequestModel({this.slectedUnitId, this.productType});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["selected_unit_id"] = slectedUnitId;
    data["product_type"] = productType;
    return data;
  }
}

////////////////Response Model///////////////

class UnitImagesResponseModel {
  int? status;
  String? message;
  UnitImages? data;

  UnitImagesResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });
  UnitImagesResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json['data'] != null ? UnitImages.fromJson(json['data']) : null;
  }
}

class UnitImages {
  UnitBasedProductImagePath? unitBasedProductImagePath;

  UnitImages({
    required this.unitBasedProductImagePath,
  });
  UnitImages.fromJson(Map<String, dynamic> json) {
    unitBasedProductImagePath = json['unit_based_product_image_path'] != null
        ? UnitBasedProductImagePath.fromJson(
            json['unit_based_product_image_path'])
        : null;
  }
}

class UnitBasedProductImagePath {
  List? imageList;
  int? productUnitId;
  int? shopId;
  String? productType;
  String? addToCartCheck;
  UnitBasedProductImagePath({
    required this.imageList,
    required this.productUnitId,
    required this.shopId,
    required this.productType,
    required this.addToCartCheck,
  });
  UnitBasedProductImagePath.fromJson(Map<String, dynamic> json) {
    if (json["img_arr"] != null) {
      imageList = [];
      json["img_arr"].forEach((v) {
        imageList!.add((v));
      });
    }
    productUnitId = json["product_unit_id"];
    shopId = json["shop_id"];
    productType = json["product_type"];
    addToCartCheck = json["add_to_cart_check"];
  }
}
