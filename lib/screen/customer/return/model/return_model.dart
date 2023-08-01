
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';

class COrderReturnListRequestModel {
  String? orderId;



  COrderReturnListRequestModel({this.orderId,});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["order_id"] = orderId;
        return data;
  }
}
/////////////////////////////////////////////////////////////////
class COrderReturnListResponseModel {
  int? status;
  String? message;
  ReturnProductListData? returnproductlistdata;

  COrderReturnListResponseModel({
    required this.status,
    required this.message,
    required this.returnproductlistdata,
  });
  COrderReturnListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    returnproductlistdata = json['data'] != null ? ReturnProductListData.fromJson(json['data']) : null;
  }

}

class ReturnProductListData {
  OrderDetails? orderDetails;
  ShopDetails? shopDetails;
  List<RefundReasonDetail>? refundReasonDetails;
  List<OrderProductDetail>? orderProductDetails;

  ReturnProductListData({
    required this.orderDetails,
    required this.shopDetails,
    required this.refundReasonDetails,
    required this.orderProductDetails,
  });
  ReturnProductListData.fromJson(Map<String, dynamic> json) {
    orderDetails = json['order_details'] != null
        ? OrderDetails.fromJson(json['order_details'])
        : null;
    shopDetails = json['shop_details'] != null
        ? ShopDetails.fromJson(json['shop_details'])
        : null;
    if (json["refund_reason_details"] != null) {
      refundReasonDetails = <RefundReasonDetail>[];
      json["refund_reason_details"].forEach((v) {
        refundReasonDetails!.add(RefundReasonDetail.fromJson(v));
      });
    }

    if (json["order_product_details"] != null) {
      orderProductDetails = <OrderProductDetail>[];
      json["order_product_details"].forEach((v) {
        orderProductDetails!.add(OrderProductDetail.fromJson(v));
      });
    }
  }

}

class OrderDetails {
  int? id;
  String? createdAt;
  String? shopName;
  String? orderUniqueId;
  String? deliveryDate;
  String? deliverySlot;
  String? subTotalAmount;
  String? totalAmount;
  String? totalDiscount;
  String? deliveryCharges;
  String? totalItems;
  String? orderStatus;

  OrderDetails({
    required this.id,
    required this.createdAt,
    required this.shopName,
    required this.orderUniqueId,
    required this.deliveryDate,
    required this.deliverySlot,
    required this.subTotalAmount,
    required this.totalAmount,
    required this.totalDiscount,
    required this.deliveryCharges,
    required this.totalItems,
    required this.orderStatus,
  });
  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    createdAt = json["created_at"];
    shopName = json["shop_name"];
    orderUniqueId = json["order_unique_id"];
    deliveryDate = json["delivery_date"];
    deliverySlot = json["delivery_slot"];
    subTotalAmount = json["sub_total_amount"];
    totalAmount = json["total_amount"];
    totalDiscount = json["total_discount"];
    deliveryCharges = json["delivery_charges"];
    totalItems = json["total_items"];
    orderStatus = json["order_status"];
  }

}

class OrderProductDetail {
  int? id;
  String? shopName;
  String? productType;
  int? productUnitId;
  String? productName;
  String? productImagePath;
  String? productImageName;
  String? productWeight;
  String? unit;
  String? status;
  String? productQuantity;
  String? productMrpPrice;
  String? productOfferPrice;

  OrderProductDetail({
    required this.id,
    required this.shopName,
    required this.productType,
    required this.productUnitId,
    required this.productName,
    required this.productImagePath,
    required this.productImageName,
    required this.productWeight,
    required this.unit,
    required this.status,
    required this.productQuantity,
    required this.productMrpPrice,
    required this.productOfferPrice,
  });
  OrderProductDetail.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    shopName = json["shop_name"];
    productType = json["product_type"];
    productUnitId = json["product_unit_id"];
    productName = json["product_name"];
    productImagePath = json["product_image_path"];
    productImageName = json["product_image_name"];
    productWeight = json["product_weight"];
    unit = json["unit"];
    status = json["status"];
    productQuantity = json["product_quantity"];
    productMrpPrice = json["product_mrp_price"];
    productOfferPrice = json["product_offer_price"];
  }

}

class RefundReasonDetail {
  int? id;
  String? reason;

  RefundReasonDetail({
    required this.id,
    required this.reason,
  });
  RefundReasonDetail.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    reason = json["reason"];
  }
}
