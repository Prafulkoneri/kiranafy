class GetCountryListResModel {
  int? status;
  String? message;
  List<CountryData>? countryData;

  GetCountryListResModel({
    this.message,
    this.status,
    this.countryData,
  });

  GetCountryListResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    if (json["data"] != null) {
      countryData = <CountryData>[];
      json["data"].forEach((v) {
        countryData!.add(CountryData.fromJson(v));
      });
    }
  }
}

class CountryData {
  int? id;
  String? countryName;

  CountryData({
    this.id,
    this.countryName,
  });

  CountryData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    countryName = json["country_name"];
  }
}
