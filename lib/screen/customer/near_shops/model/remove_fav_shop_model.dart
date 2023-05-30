class RemoveFavReqModel {
  String? shopId;
  RemoveFavReqModel({
    this.shopId,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["shop_id"] = shopId;
    return data;
  }
}

class RemoveFavResModel {
  int? status;
  String? message;
  RemoveFavResModel({
    this.message,
    this.status,
  });
  RemoveFavResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
