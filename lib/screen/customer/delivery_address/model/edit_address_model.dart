///////////Request model////////////

class EditDeliveryAddressRequestModel {
  String? deliveryAddressId;

  EditDeliveryAddressRequestModel({
    required this.deliveryAddressId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["delivery_address_id"] = deliveryAddressId;
    return data;
  }
}

////////////Res Model//////////
class EditDeliveryAddressResponseModel {
  int? status;
  String? message;

  EditDeliveryAddressResponseModel({
    required this.status,
    required this.message,
  });
  EditDeliveryAddressResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
