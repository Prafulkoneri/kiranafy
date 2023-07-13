class NotificationModel {
  int? status;
  String? message;
  NotificationData? notificationdata;

  NotificationModel({
    required this.status,
    required this.message,
    required this.notificationdata,
  });
  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    notificationdata =
        json['data'] != null ? NotificationData.fromJson(json['data']) : null;
  }
}

class NotificationData {
  List<NotificationList>? notificationList;

  NotificationData({
    required this.notificationList,
  });
  NotificationData.fromJson(Map<String, dynamic> json) {
    if (json["notification_list"] != null) {
      notificationList = <NotificationList>[];
      json["notification_list"].forEach((v) {
        notificationList!.add(NotificationList.fromJson(v));
      });
    }
  }
}

class NotificationList {
  String? title;
  String? notificationDescription;
  String? notificationImagePath;
  String? createdAt;
  String? notificationType;
  String? orderId;

  NotificationList({
    required this.title,
    required this.notificationDescription,
    required this.notificationImagePath,
    required this.createdAt,
    required this.notificationType,
    required this.orderId,
  });
  NotificationList.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    notificationDescription = json["notification_description"];
    notificationImagePath = json["notification_image_path"];
    createdAt = json["created_at"];
    notificationType = json["notification_type"];
    orderId = json["order_id"];
  }
}
