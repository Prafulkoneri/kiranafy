class SettingModel {
  int? status;
  String? message;

  SettingModel({
    required this.status,
    required this.message,
  });
  SettingModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
