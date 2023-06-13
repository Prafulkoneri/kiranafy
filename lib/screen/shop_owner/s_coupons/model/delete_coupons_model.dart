class DeleteCouponsResModel {
  int? status;
  String? message;

  DeleteCouponsResModel({
    required this.status,
    required this.message,
  });
  DeleteCouponsResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}