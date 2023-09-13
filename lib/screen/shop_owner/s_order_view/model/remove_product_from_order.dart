import '../../../customer/delivery_view/model/order_view_model.dart';

///////////////REQUEST MODEL//////////////
class AddRemoveProductFromOrderReqModel {
  String? orderProductId;

  AddRemoveProductFromOrderReqModel({
    this.orderProductId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["order_product_id"] = orderProductId;

    return data;
  }
}

//////////////////RESPONSE MODEL///////////////////////
class AddRemoveProductFromOrderResModel {
  int? status;
  String? message;
  AddRemoveData? data;

  AddRemoveProductFromOrderResModel({
    required this.status,
    required this.message,
  });
  AddRemoveProductFromOrderResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json['data'] != null ? AddRemoveData.fromJson(json['data']) : null;
  }
}

class AddRemoveData {
  String? subTotalAmount;
  String? totalAmount;
  String? totalDiscount;
  String? deliveryCharges;
  String? totalRefundAmount;
  CouponDetails? couponDetails;
  AddRemoveData({
    this.totalAmount,
    this.totalDiscount,
    this.deliveryCharges,
    this.subTotalAmount,
    this.totalRefundAmount,
    this.couponDetails,
  });
  AddRemoveData.fromJson(Map<String, dynamic> json) {
    subTotalAmount = json["sub_total_amount"];
    totalAmount = json["total_amount"];
    totalDiscount = json["total_discount"];
    deliveryCharges = json["delivery_charges"];
    totalRefundAmount = json["order_refund_amount"];
    couponDetails = json['coupon_details'] != null
        ? CouponDetails.fromJson(json['coupon_details'])
        : null;
  }
}
