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
  List<SelectedProducts>? data;

  GetSelectedProductsResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  GetSelectedProductsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];

    if (json["data"] != null) {
      data = <SelectedProducts>[];
      json["data"].forEach((v) {
        data!.add(SelectedProducts.fromJson(v));
      });
    }
  }
}

class SelectedProducts {
  int? id;
  String? productName;
  String? productImagePath;
  List<UnitDetail>? unitDetails;

  SelectedProducts({
    required this.id,
    required this.productName,
    required this.productImagePath,
    required this.unitDetails,
  });
  SelectedProducts.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productImagePath = json["product_image_path"];
    productName = json["product_name"];

    if (json["countries"] != null) {
      unitDetails = <UnitDetail>[];
      json["countries"].forEach((v) {
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
    mrpPrice = json["mrp_price"];
    offerPrice = json["offer_price"];
  }
}
