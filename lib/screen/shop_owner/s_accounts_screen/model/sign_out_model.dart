class ShopLogoutResModel {
  int? status;
  String? message;
  // String data;

  ShopLogoutResModel({
    required this.status,
    required this.message,
    // this.data,
  });
  ShopLogoutResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
