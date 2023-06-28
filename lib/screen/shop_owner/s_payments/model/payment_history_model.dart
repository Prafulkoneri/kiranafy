class PaymentHistoaryRequestModel {
  String? date;

  PaymentHistoaryRequestModel({
    this.date,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["date"] = date;

    return data;
  }
}

////////////////////////
class PaymentHistoaryResModel {
  int? status;
  String? message;
  PaymentHistoryData? paymentdata;

  PaymentHistoaryResModel({
    required this.status,
    required this.message,
    required this.paymentdata,
  });
  PaymentHistoaryResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    paymentdata =
        json['data'] != null ? PaymentHistoryData.fromJson(json['data']) : null;
  }
}

class PaymentHistoryData {
  List<OrdersList>? ordersList;
  int? currentMonthCollection;
  int? totalBusiness;

  PaymentHistoryData({
    required this.ordersList,
    required this.currentMonthCollection,
    required this.totalBusiness,
  });
  PaymentHistoryData.fromJson(Map<String, dynamic> json) {
    if (json["orders_list"] != null) {
      ordersList = <OrdersList>[];
      json["orders_list"].forEach((v) {
        ordersList!.add(OrdersList.fromJson(v));
      });
    }
    currentMonthCollection = json['current_month_collection'];
    totalBusiness = json['total_business'];
  }
}

class OrdersList {
  int? id;
  String? orderUniqueId;
  String? createdAt;
  String? customerName;
  String? totalAmount;
  String? paymentMode;

  OrdersList({
    required this.id,
    required this.orderUniqueId,
    required this.createdAt,
    required this.customerName,
    required this.totalAmount,
    required this.paymentMode,
  });
  OrdersList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    orderUniqueId = json["order_unique_id"];
    createdAt = json["created_at"];
    customerName = json['customer_name'];
    totalAmount = json['total_amount'];
    paymentMode = json['payment_mode'];
  }
}
