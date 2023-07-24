class ViewTicketRequestModel {
  String? ticketId;

  ViewTicketRequestModel({
    this.ticketId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["ticket_id"] = ticketId;
    return data;
  }
}

/////////////////////////////////////
class ViewTicketResModel {
  int? status;
  String? message;
  ViewTicketData? viewTicketData;

  ViewTicketResModel({
    required this.status,
    required this.message,
    required this.viewTicketData,
  });
  ViewTicketResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    viewTicketData =
        json['data'] != null ? ViewTicketData.fromJson(json['data']) : null;
  }
}

class ViewTicketData {
  TicketDetails? ticketDetails;
  List<TicketRepliesList>? ticketRepliesList;

  ViewTicketData({
    required this.ticketDetails,
    required this.ticketRepliesList,
  });
  ViewTicketData.fromJson(Map<String, dynamic> json) {
    ticketDetails = json['ticket_details'] != null
        ? TicketDetails.fromJson(json['ticket_details'])
        : null;
    if (json["ticket_replies_list"] != null) {
      ticketRepliesList = <TicketRepliesList>[];
      json["ticket_replies_list"].forEach((v) {
        ticketRepliesList!.add(TicketRepliesList.fromJson(v));
      });
    }
  }
}

class TicketDetails {
  int? id;
  String? ticketUniqueId;
  String? subject;
  String? description;
  String? ticketStatus;
  String? createdAt;

  TicketDetails({
    required this.id,
    required this.ticketUniqueId,
    required this.subject,
    required this.description,
    required this.ticketStatus,
    required this.createdAt,
  });
  TicketDetails.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    ticketUniqueId = json["ticket_unique_id"];
    subject = json["subject"];
    description = json["description"];
    ticketStatus = json["ticket_status"];
    createdAt = json["created_at"];
  }
}

class TicketRepliesList {
  int? id;
  String? remark;
  String? type;
  String? createdAt;
  String? name;
  String? profileImagePath;
  String? profileImageName;

  TicketRepliesList({
    required this.id,
    required this.remark,
    required this.type,
    required this.createdAt,
    required this.name,
    required this.profileImagePath,
    required this.profileImageName,
  });
  TicketRepliesList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    remark = json["remark"];
    type = json["type"];
    createdAt = json["created_at"];
    name = json["name"];
    profileImagePath = json["profile_image_path"];
    profileImageName = json["profile_image_name"];
  }
}
