class RemoveFvrtShopReqModel {
  int? id;

  RemoveFvrtShopReqModel({
    required this.id,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data["id"] = id;

    return data;
  }
}

/////////
class RemoveFvrtShopResModel {
  int? status;
  String? message;

  RemoveFvrtShopResModel({
    required this.status,
    required this.message,
  });
  RemoveFvrtShopResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
