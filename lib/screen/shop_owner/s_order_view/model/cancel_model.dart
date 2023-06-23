class CancelModel {
  int? status;
  String? message;
  List<CancelReasonList>? cancelReasondata;

  CancelModel({
    required this.status,
    required this.message,
    required this.cancelReasondata,
  });
  CancelModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    if (json["data"] != null) {
      cancelReasondata = <CancelReasonList>[];
      json["data"].forEach((v) {
        cancelReasondata!.add(CancelReasonList.fromJson(v));
      });
    }
  }
}

class CancelReasonList {
  int? id;
  String? reason;

  CancelReasonList({
    required this.id,
    required this.reason,
  });
  CancelReasonList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    reason = json["reason"];
  }
}
