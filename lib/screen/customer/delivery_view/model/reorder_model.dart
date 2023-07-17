class CustomerReorderRequesstModel {
  String? orderId;

  // CustomerOrderViewRequestModel({
  //   this.orderId,
  // });

  // Map<String, dynamic> toJson() {
  //   Map<String, dynamic> data = {};
  //   data["order_id"] = orderId;

  //   return data;
  // }
}

////////////////////////////////////////REORDER REPO////////////////////////////////////
class CustomerReorderRespponseModel {
  int? status;
  String? message;
  // OrderViewData? orderData;

  CustomerReorderRespponseModel({
    required this.status,
    required this.message,
    // required this.orderData,
  });
  CustomerReorderRespponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    // orderData =
    //     json['data'] != null ? OrderViewData.fromJson(json['data']) : null;
  }
}
