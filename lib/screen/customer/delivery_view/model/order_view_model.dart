import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';

class CustomerOrderViewRequestModel {
  String? orderId;

  CustomerOrderViewRequestModel({
    this.orderId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["order_id"] = orderId;

    return data;
  }
}

////////////////////////RESPONSE MODEL///////////////////
class CustomerOrderViewResponseModel {
  int? status;
  String? message;
  OrderViewData? orderData;

  CustomerOrderViewResponseModel({
    required this.status,
    required this.message,
    required this.orderData,
  });
  CustomerOrderViewResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    orderData =
        json['data'] != null ? OrderViewData.fromJson(json['data']) : null;
  }
}

class OrderViewData {
  OrderDetails? orderDetails;
  CouponDetails? couponDetails;
  ShopDetails? shopDetails;
  DeliveryAddressDetails? deliveryAddressDetails;
  List<OrderProductDetail>? orderProductDetails;

  OrderViewData({
    required this.orderDetails,
    required this.couponDetails,
    required this.shopDetails,
    required this.deliveryAddressDetails,
    required this.orderProductDetails,
  });
  OrderViewData.fromJson(Map<String, dynamic> json) {
    orderDetails = json['order_details'] != null
        ? OrderDetails.fromJson(json['order_details'])
        : null;
    couponDetails = json['coupon_details'] != null
        ? CouponDetails.fromJson(json['coupon_details'])
        : null;
    shopDetails = json['shop_details'] != null
        ? ShopDetails.fromJson(json['shop_details'])
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
  String? deliveryCode;
  String? deliveryCharges;
  String? paymentMode;
  String? transactionId;
  String? orderStatus;
  String? canCancelOrder;
  String? subTotalAmount;
  String? refundOrderStatus;
  String? reason;
  String? customerRefundReason;
  String? customerRefundAmount;
  String? refundProductCount;
  String? refundPaymentStatus;
  String? shopOwnerRefundRejectReason;
  String? shopOwnerRefundPayableAmount;
  String? shopOwnerRefundPaymentType;
  String? shopOwnerRefundTransactionId;
  String? refundDatetime;
  String? deliveryType;
  String? shopOwnerCancelledReason;
  String? customerCancelledReason;

  OrderDetails(
      {required this.id,
      required this.createdAt,
      required this.orderUniqueId,
      required this.deliveryDate,
      required this.deliverySlot,
      required this.totalAmount,
      required this.totalDiscount,
      required this.deliveryCode,
      required this.deliveryCharges,
      required this.paymentMode,
      required this.transactionId,
      required this.orderStatus,
      required this.canCancelOrder,
      required this.subTotalAmount,
      this.shopOwnerRefundPayableAmount,
      required this.customerRefundAmount,
      this.customerRefundReason,
        this.shopOwnerCancelledReason,
        this.customerCancelledReason,
      this.reason,
      this.refundDatetime,
      this.refundOrderStatus,
      this.refundPaymentStatus,
      this.refundProductCount,
      this.shopOwnerRefundPaymentType,
      this.shopOwnerRefundRejectReason,
      this.deliveryType,
      this.shopOwnerRefundTransactionId});
  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    createdAt = json["created_at"];
    orderUniqueId = json["order_unique_id"];
    deliveryDate = json["delivery_date"];
    deliverySlot = json["delivery_slot"];
    totalAmount = json["total_amount"];
    totalDiscount = json["total_discount"];
    deliveryCode = json["delivery_code"];
    deliveryCharges = json["delivery_charges"];
    paymentMode = json["payment_mode"];
    transactionId = json["transaction_id"];
    orderStatus = json["order_status"];
    canCancelOrder = json["can_cancel_order"];
    subTotalAmount = json["sub_total_amount"];
    refundOrderStatus = json["refund_order_status"];
    reason = json["reason"];
    customerRefundReason = json["custom_refund_reason"];
    customerRefundAmount = json["customer_refund_amount"];
    refundProductCount = json["refund_product_count"];
    refundPaymentStatus = json["refund_payment_status"];
    shopOwnerRefundRejectReason = json["shop_owner_refund_reject_reason"];
    shopOwnerRefundPayableAmount = json["shop_owner_refund_payable_amount"];
    shopOwnerRefundPaymentType = json["shop_owner_refund_payment_type"];
    shopOwnerRefundTransactionId = json["shop_owner_refund_transaction_id"];
    refundDatetime = json["refund_datetime"];
    deliveryType = json["delivery_type"];
    shopOwnerCancelledReason = json["shop_owner_order_cancelled_reason"];
    customerCancelledReason = json["customer_order_cancelled_reason"];
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
  String? unit;
  String? productQuantity;
  String? productMrpPrice;
  String? productOfferPrice;
  int? productTotalPrice;
  String? returnStatus;

  OrderProductDetail({
    required this.id,
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
    required this.returnStatus,
  });
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
    returnStatus = json["return_status"];
  }
}

// class ShopDetails {
//   int id;
//   String shopName;
//   String shopAddress;
//   String areaName;
//   String cityName;
//   int shopPincode;
//   String shopOwnerSupportNumber;
//   String isFavourite;

//   ShopDetails({
//     required this.id,
//     required this.shopName,
//     required this.shopAddress,
//     required this.areaName,
//     required this.cityName,
//     required this.shopPincode,
//     required this.shopOwnerSupportNumber,
//     required this.isFavourite,
//   });
// }
