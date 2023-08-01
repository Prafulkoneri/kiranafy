class ChangeSettingsRequestModel {
  String? appNotification;

  ChangeSettingsRequestModel({
    required this.appNotification,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["app_notification"] = appNotification;

    return data;
  }
}

/////////////////////Response////////////////////
class ChangeSettingsResponseModel {
  int? status;
  String? message;

  ChangeSettingsResponseModel({
    required this.status,
    required this.message,
  });
  ChangeSettingsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
