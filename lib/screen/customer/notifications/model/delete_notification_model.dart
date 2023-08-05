class CNotificationModel {
  int? status;
  String? message;

  CNotificationModel({
    required this.status,
    required this.message,
  });
  CNotificationModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
