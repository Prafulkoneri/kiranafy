class CustomerPlaceOrderReqModel {
  String? cartId;
  String? shopId;
  String? couponId;
  String? totalItems;
  String? finalTotalAmount;
  String? finalTotalDiscount;
  String? customerDeliveryType;
  String? customerDeliverySlot;
  String? customerDeliveryDate;
  String? customerDeliveryAddressId;
  String? finalSubTotal;
  String? finalDeliveryCharges;
  String? customerPaymentMode;

  CustomerPlaceOrderReqModel(
      {this.cartId,
      this.shopId,
      this.couponId,
      this.totalItems, //
      this.finalTotalAmount, //
      this.finalTotalDiscount, //
      this.customerDeliveryType, //
      this.customerDeliverySlot, //
      this.customerDeliveryDate, //
      this.customerDeliveryAddressId, //
      this.finalSubTotal,
      this.finalDeliveryCharges,
      this.customerPaymentMode});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["cart_id"] = cartId;
    data["shop_id"] = shopId;
    data["coupon_id"] = couponId;
    data["total_items"] = totalItems;
    data["final_total_amount"] = finalTotalAmount;
    data["final_total_discount"] = finalTotalDiscount;
    data["customer_delivery_type"] = customerDeliveryType;
    data["customer_delivery_slot"] = customerDeliverySlot;
    data["customer_delivery_date"] = customerDeliveryDate;
    data["customer_delivery_address_id"] = customerDeliveryAddressId;
    data["final_sub_total"] = finalSubTotal;
    data["final_delivery_charges"] = finalDeliveryCharges;
    data["customer_payment_mode"] = customerPaymentMode;
    return data;
  }
}

//////////////////Response Model///////////////

class CustomerPlaceOrderResponseModel {
  int? status;
  String? message;
  int? orderId;

  CustomerPlaceOrderResponseModel(
      {required this.status, required this.message, required this.orderId});
  CustomerPlaceOrderResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    orderId = json["order_id"];
  }
}
