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

  ShopOrderViewData({
    required this.orderDetails,
    required this.couponDetails,
    required this.deliveryAddressDetails,
    required this.orderProductDetails,
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
  String ? status;
  String? unit;
  String? productQuantity;
  String? productMrpPrice;
  String? productOfferPrice;
  int? productTotalPrice;

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
    required this.status,
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
    status = json["status"];
  }
}
