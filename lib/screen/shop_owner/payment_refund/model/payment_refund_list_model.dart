class ShopPaymentRefundListRequestModel {
  String? date;

  ShopPaymentRefundListRequestModel({
    this.date,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["date"] = date;

    return data;
  }
}

////////////////////////////////////////////
class ShopPaymentRefundListResponseModel {
  int? status;
  String? message;
  PaymentRefundData? paymentrefunddata;

  ShopPaymentRefundListResponseModel({
    required this.status,
    required this.message,
    required this.paymentrefunddata,
  });
  ShopPaymentRefundListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    paymentrefunddata =
        json['data'] != null ? PaymentRefundData.fromJson(json['data']) : null;
  }
}

class PaymentRefundData {
  List<OrdersRefundListElement>? ordersRefundList;
  List<OrdersRefundListElement>? pendingOrdersList;
  List<ConfirmedOrdersList>? confirmedOrdersList;
  int? currentMonthCollection;
  int? totalBusiness;

  PaymentRefundData({
    required this.ordersRefundList,
    required this.pendingOrdersList,
    required this.confirmedOrdersList,
    required this.currentMonthCollection,
    required this.totalBusiness,
  });
  PaymentRefundData.fromJson(Map<String, dynamic> json) {
    if (json["orders_refund_list"] != null) {
      ordersRefundList = <OrdersRefundListElement>[];
      json["orders_refund_list"].forEach((v) {
        ordersRefundList!.add(OrdersRefundListElement.fromJson(v));
      });
    }
    if (json["pending_orders_list"] != null) {
      pendingOrdersList = <OrdersRefundListElement>[];
      json["pending_orders_list"].forEach((v) {
        pendingOrdersList!.add(OrdersRefundListElement.fromJson(v));
      });
    }
    if (json["confirmed_orders_list"] != null) {
      confirmedOrdersList = <ConfirmedOrdersList>[];
      json["confirmed_orders_list"].forEach((v) {
        confirmedOrdersList!.add(ConfirmedOrdersList.fromJson(v));
      });
    }
    currentMonthCollection = json['current_month_collection'];
    totalBusiness = json['total_business'];
  }
}

class ConfirmedOrdersList {
  int? id;
  String? customerName;
  String? orderUniqueId;
  String? refundProductCount;
  String? customerRefundAmount;
  String? createdAt;
  String? paymentMode;

  ConfirmedOrdersList({
    required this.id,
    required this.customerName,
    required this.orderUniqueId,
    required this.refundProductCount,
    required this.customerRefundAmount,
    required this.createdAt,
    required this.paymentMode,
  });
  ConfirmedOrdersList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    customerName = json["customer_name"];
    orderUniqueId = json["order_unique_id"];
    refundProductCount = json['refund_product_count'];
    customerRefundAmount = json['customer_refund_amount'];
    createdAt = json['created_at'];
    paymentMode = json['payment_mode'];
  }
}

class OrdersRefundListElement {
  int? id;
  String? orderUniqueId;
  String? createdAt;
  String? customerName;
  String? totalAmount;
  String? paymentMode;
  String? totalItems;

  OrdersRefundListElement({
    required this.id,
    required this.orderUniqueId,
    required this.createdAt,
    required this.customerName,
    required this.totalAmount,
    required this.paymentMode,
    required this.totalItems,
  });
  OrdersRefundListElement.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    orderUniqueId = json["order_unique_id"];
    createdAt = json['created_at'];
    customerName = json["customer_name"];
    totalAmount = json["total_amount"];
    paymentMode = json['payment_mode'];
    totalItems = json['total_items'];
  }
}
