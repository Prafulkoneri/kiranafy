class UnitListtoCreateProductResModel {
  int? status;
  String? message;
  UnitListCreateproductData? unitlistproductdata;

  UnitListtoCreateProductResModel({
    required this.status,
    required this.message,
    required this.unitlistproductdata,
  });
  UnitListtoCreateProductResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    unitlistproductdata = json['data'] != null
        ? UnitListCreateproductData.fromJson(json['data'])
        : null;
  }
}

class UnitListCreateproductData {
  List<UnitListData>? unitData;

  UnitListCreateproductData({
    required this.unitData,
  });

  UnitListCreateproductData.fromJson(Map<String, dynamic> json) {
    if (json["unit_data"] != null) {
      unitData = <UnitListData>[];
      json["unit_data"].forEach((v) {
        unitData!.add(UnitListData.fromJson(v));
      });
    }
  }
}

class UnitListData {
  int? id;
  String? unit;

  UnitListData({
    required this.id,
    required this.unit,
  });

  UnitListData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    unit = json["unit"];
  }
}
