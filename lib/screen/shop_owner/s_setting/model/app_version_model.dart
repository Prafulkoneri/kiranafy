class AppVersionModel {
  int? status;
  String? message;
  AppVersionData? appversiondata;

  AppVersionModel({
    required this.status,
    required this.message,
    required this.appversiondata,
  });
  AppVersionModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    appversiondata =
        json['data'] != null ? AppVersionData.fromJson(json['data']) : null;
  }
}

class AppVersionData {
  String? appVersion;

  AppVersionData({
    required this.appVersion,
  });
  AppVersionData.fromJson(Map<String, dynamic> json) {
    appVersion = json["app_version"];
  }
}
