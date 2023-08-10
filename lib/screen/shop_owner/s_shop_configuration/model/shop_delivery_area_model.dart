class ShopDeliveryAreaDataReqModel {
  String? areaname;

  ShopDeliveryAreaDataReqModel({
    this.areaname,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["areaname"] = areaname;

    return data;
  }
}

////////////////////////////////////
class ShopDeliveryAreaDataResModel {
  int? status;
  String? message;
  List<AreaList>? areaList;

  ShopDeliveryAreaDataResModel({
    required this.status,
    required this.message,
    required this.areaList,
  });
  ShopDeliveryAreaDataResModel.fromJson(Map<String, dynamic> json) {
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
