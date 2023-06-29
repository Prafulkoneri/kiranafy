class GetTicketListModel {
  int? status;
  String? message;
  List<TicketListData>? ticketList;

  GetTicketListModel({
    required this.status,
    required this.message,
    required this.ticketList,
  });
  GetTicketListModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    if (json["data"] != null) {
      ticketList = <TicketListData>[];
      json["data"].forEach((v) {
        ticketList!.add(TicketListData.fromJson(v));
      });
    }
  }
}

class TicketListData {
  int? id;
  String? ticketUniqueId;
  String? subject;
  String? description;
  String? ticketStatus;
  String? createdAt;

  TicketListData({
    required this.id,
    required this.ticketUniqueId,
    required this.subject,
    required this.description,
    required this.ticketStatus,
    required this.createdAt,
  });
  TicketListData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    ticketUniqueId = json["ticket_unique_id"];
    subject = json["subject"];
    description = json["description"];
    ticketStatus = json["ticket_status"];
    createdAt = json["created_at"];
  }
}
