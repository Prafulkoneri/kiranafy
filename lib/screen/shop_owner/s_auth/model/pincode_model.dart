class GetPincodeReqModel {
  String? areaId;

  GetPincodeReqModel({
    this.areaId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["area_id"] = areaId;
    return data;
  }
}

class GetPincodeResModel {
  int? status;
  String? message;
  List? pincodeData;

  GetPincodeResModel({
    this.message,
    this.status,
    this.pincodeData,
  });

  GetPincodeResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    if (json["data"] != null) {
      pincodeData = [];
      json["data"].forEach((v) {
        pincodeData!.add(v);
      });
    }
  }
}
