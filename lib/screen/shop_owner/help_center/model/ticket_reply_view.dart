class TicketReplyRequestModel {
  String? ticketId;
  String? ticketRemark;
  String? ticketStatus;
  String ? type;

  TicketReplyRequestModel({
    this.ticketId,
    this.ticketRemark,
    this.ticketStatus,
    this.type,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["ticket_id"] = ticketId;
    data["remark"] = ticketRemark;
    data["ticket_status"] = ticketStatus;
    data["type"] = type;
    return data;
  }
}

/////////////////////////////////////
class TicketReplyResModel {
  int? status;
  String? message;
  ReplyData? reply;

  TicketReplyResModel({
    required this.status,
    required this.message,
  });
  TicketReplyResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    reply = json['data'] != null ? ReplyData.fromJson(json['data']) : null;
  }
}

class ReplyData {
  int? id;
  String? remark;
  String? createdAt;
  String? name;
  String? profileImagePath;
  String? profileImageName;
  ReplyData({
    required this.id,
    required this.remark,
    required this.createdAt,
    required this.name,
    required this.profileImagePath,
    required this.profileImageName,
  });
  ReplyData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    remark = json["remark"];
    createdAt = json["created_at"];
    name = json["name"];
    profileImagePath = json["profile_image_path"];
    profileImageName = json["profile_image_name"];
  }
}
