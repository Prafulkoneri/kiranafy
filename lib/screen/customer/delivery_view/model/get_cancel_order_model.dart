class CustomerCancelOrderModel {
  int? status;
  String? message;
  List<CustomerCancelReasonList>? cancelReasondata;

  CustomerCancelOrderModel({
    required this.status,
    required this.message,
    required this.cancelReasondata,
  });
  CustomerCancelOrderModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    if (json["data"] != null) {
      cancelReasondata = <CustomerCancelReasonList>[];
      json["data"].forEach((v) {
        cancelReasondata!.add(CustomerCancelReasonList.fromJson(v));
      });
    }
  }
}

class CustomerCancelReasonList {
  int? id;
  String? reason;

  CustomerCancelReasonList({
    required this.id,
    required this.reason,
  });
  CustomerCancelReasonList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    reason = json["reason"];
  }
}
