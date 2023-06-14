class ShopCartDeleteResModel {
  int? status;
  String? message;

  ShopCartDeleteResModel({
    required this.status,
    required this.message,
  });
  ShopCartDeleteResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
