////Request Model///////////
class UnitImagesRequestModel {
  String? slectedUnitId;
  UnitImagesRequestModel({this.slectedUnitId});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["selected_unit_id"] = slectedUnitId;
    return data;
  }
}

////////////////Response Model///////////////
// class UnitImagesResponseModel {
//   int? status;
//   String? message;
//   UnitImages? data;

//   UnitImagesResponseModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });
//   UnitImagesResponseModel.fromJson(Map<String, dynamic> json) {
//     status = json["status"];
//     message = json["message"];
//     data = json['data'] != null ? UnitImages.fromJson(json['data']) : null;
//   }
// }

// class UnitImages {
//   String? unitBasedProductImage1Path;
//   String? unitBasedProductImage1Name;
//   String? unitBasedProductImage2Path;
//   String? unitBasedProductImage2Name;
//   String? unitBasedProductImage3Path;
//   String? unitBasedProductImage3Name;

//   UnitImages({
//     required this.unitBasedProductImage1Path,
//     required this.unitBasedProductImage1Name,
//     required this.unitBasedProductImage2Path,
//     required this.unitBasedProductImage2Name,
//     required this.unitBasedProductImage3Path,
//     required this.unitBasedProductImage3Name,
//   });
//   UnitImages.fromJson(Map<String, dynamic> json) {
//     unitBasedProductImage1Path = json["unit_based_product_image_1_path"];
//     unitBasedProductImage1Name = json["unit_based_product_image_1_name"];
//     unitBasedProductImage2Path = json["unit_based_product_image_2_path"];
//     unitBasedProductImage2Name = json["unit_based_product_image_2_name"];
//     unitBasedProductImage3Path = json["unit_based_product_image_3_path"];
//     unitBasedProductImage3Name = json["unit_based_product_image_3_name"];
//   }
// }
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
  // List<String>? unitBasedProductImagePath;
  List? unitBasedProductImagePath;

  UnitImages({
    required this.unitBasedProductImagePath,
  });
  UnitImages.fromJson(Map<String, dynamic> json) {
    if (json["unit_based_product_image_path"] != null) {
      unitBasedProductImagePath = [];
      json["unit_based_product_image_path"].forEach((v) {
        unitBasedProductImagePath!.add((v));
      });
    }
  }
}
