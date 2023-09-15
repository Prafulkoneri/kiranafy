import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';

class OrderPaymentReqModel {
  String? cartId; //
  String? shopId; //
  String? couponId; //
  String? totalItems; //
  String? finalTotalAmount; //
  String? finalTotalDiscount; //
  String? customerDeliveryType; //
  String? customerDeliverySlot; //
  String? customerDeliveryDate; //
  String? customerDeliveryAddressId; //
  String? finalSubTotal;
  String? finalDeliveryCharges;

  OrderPaymentReqModel(
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
      this.finalDeliveryCharges});

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
    return data;
  }
}

////////////RESPONSE MODEL////////////////
class OrderPaymentResModel {
  int? status;
  String? message;
  OrderPaymentData? orderPayment;

  OrderPaymentResModel({
    required this.status,
    required this.message,
    required this.orderPayment,
  });
  OrderPaymentResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    orderPayment =
        json['data'] != null ? OrderPaymentData.fromJson(json['data']) : null;
  }
}

class OrderPaymentData {
  ShopDetails? shopDetails;
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

  OrderPaymentData({
    required this.shopDetails,
    required this.cartId,
    required this.shopId,
    required this.couponId,
    required this.totalItems,
    required this.finalTotalAmount,
    required this.finalTotalDiscount,
    required this.customerDeliveryType,
    required this.customerDeliverySlot,
    required this.customerDeliveryDate,
    required this.customerDeliveryAddressId,
  });
  OrderPaymentData.fromJson(Map<String, dynamic> json) {
    shopDetails = json['shop_details'] != null
        ? ShopDetails.fromJson(json['shop_details'])
        : null;
    cartId = json["cart_id"];
    shopId = json["shop_id"];
    couponId = json["coupon_id"];
    totalItems = json["total_items"];
    finalTotalAmount = json["final_total_amount"];
    finalTotalDiscount = json["final_total_discount"];
    customerDeliveryType = json["customer_delivery_type"];
    customerDeliverySlot = json["customer_delivery_slot"];
    customerDeliveryDate = json["customer_delivery_date"];
    customerDeliveryAddressId = json["customer_delivery_address_id"];
  }
}
