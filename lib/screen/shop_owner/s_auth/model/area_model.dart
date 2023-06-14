class GetAreaListReqModel {
  String? cityId;

  GetAreaListReqModel({
    this.cityId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["city_id"] = cityId;
    return data;
  }
}

class GetAreaListResModel {
  int? status;
  String? message;
  List<AreaData>? areaData;

  GetAreaListResModel({
    this.message,
    this.status,
    this.areaData,
  });

  GetAreaListResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    if (json["data"] != null) {
      areaData = <AreaData>[];
      json["data"].forEach((v) {
        areaData!.add(AreaData.fromJson(v));
      });
    }
  }
}

class AreaData {
  int? id;
  String? areaName;

  AreaData({
    this.id,
    this.areaName,
  });

  AreaData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    areaName = json["area_name"];
  }
}
