class CreateTicketRequestModel {
  String? ticketTypeId;
  String? subject;
  String? description;

  CreateTicketRequestModel({
    this.ticketTypeId,
    this.subject,
    this.description,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["ticket_type_id"] = ticketTypeId;
    data["subject"] = subject;
    data["description"] = description;
    return data;
  }
}

//////////////////////RESPONSE MODEL///////////////////
class CreateTicketResModel {
  int? status;
  String? message;

  CreateTicketResModel({
    required this.status,
    required this.message,
  });
  CreateTicketResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
