class DeleteAccountResModel {
  int? status;
  String? message;

  DeleteAccountResModel({
    required this.status,
    required this.message,
  });
  DeleteAccountResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
