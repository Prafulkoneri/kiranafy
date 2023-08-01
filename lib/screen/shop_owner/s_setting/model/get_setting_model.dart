class SettingsModel {
  int? status;
  String? message;
  SettingData? settingData;

  SettingsModel({
    required this.status,
    required this.message,
    required this.settingData,
  });
  SettingsModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    settingData =
        json['data'] != null ? SettingData.fromJson(json['data']) : null;
  }
}

class SettingData {
  String? appNotification;

  SettingData({
    required this.appNotification,
  });
  SettingData.fromJson(Map<String, dynamic> json) {
    appNotification = json["app_notification"];
  }
}
