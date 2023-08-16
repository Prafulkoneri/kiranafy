class OrderInvoiceRequestModel {
  String? orderId;

  OrderInvoiceRequestModel({
    this.orderId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["order_id"] = orderId;
    return data;
  }
}

///////////////////////////////////////////////
class OrderInvoiceResModel {
  int? status;
  String? message;
  OrderInvoiceData? orderinvoiecdata;

  OrderInvoiceResModel({
    required this.status,
    required this.message,
    required this.orderinvoiecdata,
  });
  OrderInvoiceResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    orderinvoiecdata =
        json['data'] != null ? OrderInvoiceData.fromJson(json['data']) : null;
  }
}

class OrderInvoiceData {
  CustomerInvoiceList? customerInvoiceList;

  OrderInvoiceData({
    required this.customerInvoiceList,
  });
  OrderInvoiceData.fromJson(Map<String, dynamic> json) {
    customerInvoiceList = json['customer_invoice_list'] != null
        ? CustomerInvoiceList.fromJson(json['customer_invoice_list'])
        : null;
  }
}

class CustomerInvoiceList {
  int? id;
  String? invoiceLink;

  CustomerInvoiceList({
    required this.id,
    required this.invoiceLink,
  });
  CustomerInvoiceList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    invoiceLink = json["invoice_link"];
  }
}
