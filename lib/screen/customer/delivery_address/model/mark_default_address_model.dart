///////////Request model////////////

class DefaultAddressRequestModel {
  String? deliveryAddressId;

  DefaultAddressRequestModel({
    required this.deliveryAddressId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["delivery_address_id"] = deliveryAddressId;

    return data;
  }
}

////////////Res Model//////////
class DefaultAddressResModel {
  int? status;
  String? message;

  DefaultAddressResModel({
    required this.status,
    required this.message,
  });
  DefaultAddressResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
