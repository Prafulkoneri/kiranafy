class NotiFicationSeenModel {
  int? status;
  String? message;
  NotificationData? notificationdata;

  NotiFicationSeenModel({
    required this.status,
    required this.message,
    required this.notificationdata,
  });

  NotiFicationSeenModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    notificationdata =
        json['data'] != null ? NotificationData.fromJson(json['data']) : null;
  }
}

class NotificationData {
  String? notificationStatus;

  NotificationData({
    required this.notificationStatus,
  });

  NotificationData.fromJson(Map<String, dynamic> json) {
    notificationStatus = json["notification_status"];
  }
}
