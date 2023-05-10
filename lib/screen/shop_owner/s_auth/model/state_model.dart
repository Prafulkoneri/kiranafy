class GetStateListReqModel{
  String ? countryId;
  GetStateListReqModel({
    this.countryId,
});
  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = {};
    data["country_id"]=countryId;
    print(data);
    return data;
  }
}

class GetStateListResModel {
  int? status;
  String? message;
  List<StateData>? stateData;

  GetStateListResModel({
    this.message,
    this.status,
    this.stateData,
  });

  GetStateListResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    if (json["data"] != null) {
      stateData = <StateData>[];
      json["data"].forEach((v) {
        stateData!.add(StateData.fromJson(v));
      });
    }
  }
}

class StateData {
  int? id;
  String? stateName;

  StateData({
    this.id,
    this.stateName,
  });

  StateData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    stateName = json["state_name"];
  }
}
