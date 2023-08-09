class ShopDeliveryAreaDataModel {
  int? status;
  String? message;
  List<AreaList>? areaList;

  ShopDeliveryAreaDataModel({
    required this.status,
    required this.message,
    required this.areaList,
  });
  ShopDeliveryAreaDataModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];

    if (json["area_list"] != null) {
      areaList = <AreaList>[];
      json["area_list"].forEach((v) {
        areaList!.add(AreaList.fromJson(v));
      });
    }
  }
}

class AreaList {
  int? id;
  String? areaName;

  AreaList({
    required this.id,
    required this.areaName,
  });
  AreaList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    areaName = json["area_name"];
  }
}
