class GetCityListReqModel{
  String ? stateId;
  GetCityListReqModel({
    this.stateId,
  });
  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = {};
    data["state_id"]=stateId;
    return data;
  }
}

class GetCityListResModel {
  int? status;
  String? message;
  List<CityData>? cityData;

  GetCityListResModel({
    this.message,
    this.status,
    this.cityData,
  });

  GetCityListResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    if (json["data"] != null) {
      cityData = <CityData>[];
      json["data"].forEach((v) {
        cityData!.add(CityData.fromJson(v));
      });
    }
  }
}

class CityData {
  int? id;
  String? cityName;

  CityData({
    this.id,
    this.cityName,
  });

  CityData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    cityName = json["city_name"];
  }
}
