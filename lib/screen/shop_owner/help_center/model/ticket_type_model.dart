class TicketTypeModel {
  int? status;
  String? message;
  List<TicketTypeData>? ticketTypeData;

  TicketTypeModel({
    required this.status,
    required this.message,
    required this.ticketTypeData,
  });
  TicketTypeModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    if (json["data"] != null) {
      ticketTypeData = <TicketTypeData>[];
      json["data"].forEach((v) {
        ticketTypeData!.add(TicketTypeData.fromJson(v));
      });
    }
  }
}

class TicketTypeData {
  int? id;
  String? ticketType;

  TicketTypeData({
    required this.id,
    required this.ticketType,
  });
  TicketTypeData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    ticketType = json["ticket_type"];
  }
}
