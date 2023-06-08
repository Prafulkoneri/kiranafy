///////////Request model////////////

class DeleteDeliveryAddressRequestModel {
  String? deliveryAddressId;

  DeleteDeliveryAddressRequestModel({
    required this.deliveryAddressId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["delivery_address_id"] = deliveryAddressId;
    return data;
  }
}

////////////Res Model//////////
class DeleteDeliveryAddressResponseModel {
  int? status;
  String? message;

  DeleteDeliveryAddressResponseModel({
    required this.status,
    required this.message,
  });
  DeleteDeliveryAddressResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
