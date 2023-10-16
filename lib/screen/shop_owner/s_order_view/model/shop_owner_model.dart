class ShopOrderViewRequestModel {
  String? orderId;

  ShopOrderViewRequestModel({
    this.orderId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["order_id"] = orderId;

    return data;
  }
}
//////////////////////RESPONSEMODEL////////////////

class ShopOrderViewResModel {
  int? status;
  String? message;
  ShopOrderViewData? shopOrderViewData;

  ShopOrderViewResModel({
    required this.status,
    required this.message,
    required this.shopOrderViewData,
  });
  ShopOrderViewResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    shopOrderViewData =
        json['data'] != null ? ShopOrderViewData.fromJson(json['data']) : null;
  }
}

class ShopOrderViewData {
  OrderDetails? orderDetails;
  CouponDetails? couponDetails;
  DeliveryAddressDetails? deliveryAddressDetails;
  List<OrderProductDetail>? orderProductDetails;
  bool? orderRefundStatus;
  String? orderRefundAmount;

  ShopOrderViewData({
    required this.orderDetails,
    required this.couponDetails,
    required this.deliveryAddressDetails,
    required this.orderProductDetails,
    required this.orderRefundAmount,
    required this.orderRefundStatus,
  });
  ShopOrderViewData.fromJson(Map<String, dynamic> json) {
    orderDetails = json['order_details'] != null
        ? OrderDetails.fromJson(json['order_details'])
        : null;
    couponDetails = json['coupon_details'] != null
        ? CouponDetails.fromJson(json['coupon_details'])
        : null;
    deliveryAddressDetails = json['delivery_address_details'] != null
        ? DeliveryAddressDetails.fromJson(json['delivery_address_details'])
        : null;
    if (json["order_product_details"] != null) {
      orderProductDetails = <OrderProductDetail>[];
      json["order_product_details"].forEach((v) {
        orderProductDetails!.add(OrderProductDetail.fromJson(v));
      });
    }
    orderRefundStatus = json["order_refund_status"];
    orderRefundAmount = json["order_refund_amount"];
  }
}

class CouponDetails {
  int? id;
  String? couponCode;
  int? couponDiscount;

  CouponDetails({
    required this.id,
    required this.couponCode,
    required this.couponDiscount,
  });
  CouponDetails.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    couponCode = json["coupon_code"];
    couponDiscount = json["coupon_discount"];
  }
}

class DeliveryAddressDetails {
  int? addressId;
  String? customerName;
  String? mobileNo;
  String? deliveryAddressType;
  String? address1;
  String? address2;

  DeliveryAddressDetails({
    required this.addressId,
    required this.customerName,
    required this.mobileNo,
    required this.deliveryAddressType,
    required this.address1,
    required this.address2,
  });
  DeliveryAddressDetails.fromJson(Map<String, dynamic> json) {
    addressId = json["address_id"];
    customerName = json["customer_name"];
    mobileNo = json["mobile_no"];
    deliveryAddressType = json["delivery_address_type"];
    address1 = json["address_1"];
    address2 = json["address_2"];
  }
}

class OrderDetails {
  int? id;
  String? createdAt;
  String? orderUniqueId;
  String? deliveryDate;
  String? deliverySlot;
  String? totalAmount;
  String? totalDiscount;
  String? deliveryCharges;
  String? paymentMode;
  String? transactionId;
  String? orderStatus;
  String? subTotal;
  String? deliveryType;
  String? shopOwnerPaymentStatus;
  String? shopOwnerRefundStatus;
  String? customerRefundPaymentStatus;
  String? shopOwnerRefundPaymentType;
  String? refundProductCount;
  String? customerRefundAmount;
  String? shopOwnerRefundTransactionId;
  String? shopOwnerRejectReason;
  String? shopOwnerCancelledReason;
  String? customerCancelledReason;
  String? shopOwnerCancelledStatus;
  String? customerCancelledStatus;
  String? shopDeliveredRefundStatus;
  int? shopDeliveredPayableAmount;
  String? shopDeliveredPayableType;
  String? shopDeliveredTransactionId;
  String? shopDeliveredCustomerPaymentStatus;
  int? shopOwnerRefunPaybelAmount;
  String? customerRefundReason;
  String ? updatedTime;
  String ? orderCancelledDateAndTime;
  String ? refundDateAndTime;
  String ? deliveredRefundDateAndTime;

  OrderDetails({
    required this.id,
    required this.createdAt,
    required this.orderUniqueId,
    required this.deliveryDate,
    required this.deliverySlot,
    required this.totalAmount,
    required this.totalDiscount,
    required this.deliveryCharges,
    required this.paymentMode,
    required this.transactionId,
    required this.orderStatus,
    required this.subTotal,
    required this.deliveryType,
    required this.shopOwnerPaymentStatus,
    required this.shopOwnerRefundStatus,
    required this.customerRefundPaymentStatus,
    required this.shopOwnerRefundTransactionId,
    required this.shopOwnerRefundPaymentType,
    required this.refundProductCount,
    required this.customerRefundAmount,
    required this.shopOwnerRejectReason,
    required this.customerCancelledReason,
    required this.shopOwnerCancelledReason,
    required this.shopOwnerCancelledStatus,
    required this.customerCancelledStatus,
    required this.shopDeliveredCustomerPaymentStatus,
    required this.shopDeliveredPayableAmount,
    required this.shopDeliveredPayableType,
    required this.shopDeliveredRefundStatus,
    required this.shopDeliveredTransactionId,
    required this.shopOwnerRefunPaybelAmount,
    required this.customerRefundReason,
    required this.updatedTime,
    required this.orderCancelledDateAndTime,
    required this.refundDateAndTime,
    required this.deliveredRefundDateAndTime,
  });
  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    createdAt = json["created_at"];
    orderUniqueId = json["order_unique_id"];
    deliveryDate = json["delivery_date"];
    deliverySlot = json["delivery_slot"];
    totalAmount = json["total_amount"];
    totalDiscount = json["total_discount"];
    deliveryCharges = json["delivery_charges"];
    paymentMode = json["payment_mode"];
    transactionId = json["transaction_id"];
    orderStatus = json["order_status"];
    subTotal = json["sub_total_amount"];
    deliveryType = json["delivery_type"];
    shopOwnerPaymentStatus = json["shop_owner_payment_status"];
    shopOwnerRefundStatus = json["refund_order_status"];
    customerRefundPaymentStatus = json["refund_payment_status"];
    shopOwnerRefundTransactionId = json["shop_owner_refund_transaction_id"];
    shopOwnerRefundPaymentType = json["shop_owner_refund_payment_type"];
    refundProductCount = json["refund_product_count"];
    customerRefundAmount = json["customer_refund_amount"];
    shopOwnerRejectReason = json["shop_owner_refund_reject_reason"];
    shopOwnerCancelledReason = json["shop_owner_order_cancelled_reason"];
    customerCancelledReason = json["customer_order_cancelled_reason"];
    shopOwnerCancelledStatus = json["shop_owner_cancelled_status"];
    customerCancelledStatus = json["customer_cancelled_status"];
    shopDeliveredCustomerPaymentStatus =
        json["shop_de_customer_payment_status"];
    shopDeliveredPayableAmount = json["shop_de_payable_amount"];
    shopDeliveredPayableType = json["shop_de_payment_type"];
    shopDeliveredRefundStatus = json["shop_de_refund_status"];
    shopDeliveredTransactionId = json["shop_de_transaction_id"];
    shopOwnerRefunPaybelAmount = json["shop_owner_refund_payable_amount"];
    customerRefundReason = json["custom_refund_reason"]; //
    updatedTime = json["updated_at"];
    orderCancelledDateAndTime = json["order_cancelled_date_and_time"];
    refundDateAndTime = json["refund_datetime"];
    deliveredRefundDateAndTime = json["delivered_refund_date_time"];
  }
}

class OrderProductDetail {
  int? id;
  String? productType;
  int? productUnitId;
  String? productName;
  String? productImagePath;
  String? productImageName;
  String? productWeight;
  String? status;
  String? unit;
  String? productQuantity;
  String? productMrpPrice;
  String? productOfferPrice;
  int? productTotalPrice;
  String? refundStatus;
  String? reason;
  String? customRefundReason;
  String? customRefundAmount;
  String? refundProductCount;

  OrderProductDetail(
      {required this.id,
      required this.productType,
      required this.productUnitId,
      required this.productName,
      required this.productImagePath,
      required this.productImageName,
      required this.productWeight,
      required this.unit,
      required this.productQuantity,
      required this.productMrpPrice,
      required this.productOfferPrice,
      required this.productTotalPrice,
      required this.status,
      required this.refundStatus,
      this.reason,
      this.refundProductCount,
      this.customRefundReason,
      this.customRefundAmount});
  OrderProductDetail.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productType = json["product_type"];
    productUnitId = json["product_unit_id"];
    productName = json["product_name"];
    productImagePath = json["product_image_path"];
    productImageName = json["product_image_name"];
    productWeight = json["product_weight"];
    unit = json["unit"];
    productQuantity = json["product_quantity"];
    productMrpPrice = json["product_mrp_price"];
    productOfferPrice = json["product_offer_price"];
    productTotalPrice = json["product_total_price"];
    status = json["status"];
    refundStatus = json["return_status"];
    reason = json["reason"];
    customRefundAmount = json["customer_refund_amount"];
    // customerRefund=json["customer_refund_amount"];
    reason = json["reason"];
    // "reason": "Quality issue",
    // "custom_refund_reason": "not good",
    // "customer_refund_amount": "20",
    // "refund_product_count": "1"
  }
}
