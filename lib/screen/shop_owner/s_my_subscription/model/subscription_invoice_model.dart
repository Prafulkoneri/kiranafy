class ShopConfigrationInvoiceRequestModel {
  String? subscriptionId;

  ShopConfigrationInvoiceRequestModel({
    this.subscriptionId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["id"] = subscriptionId;
    return data;
  }
}

//////////////////////////////////
class ShopConfigrationInvoiceResModel {
  int? status;
  String? message;
  SubscriptionInvoiceData? subscriptioninvoicedata;

  ShopConfigrationInvoiceResModel({
    required this.status,
    required this.message,
    required this.subscriptioninvoicedata,
  });
  ShopConfigrationInvoiceResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    subscriptioninvoicedata = json['data'] != null
        ? SubscriptionInvoiceData.fromJson(json['data'])
        : null;
  }
}

class SubscriptionInvoiceData {
  ShopInvoiceList? shopInvoiceList;

  SubscriptionInvoiceData({
    required this.shopInvoiceList,
  });
  SubscriptionInvoiceData.fromJson(Map<String, dynamic> json) {
    shopInvoiceList = json['shop_invoice_list'] != null
        ? ShopInvoiceList.fromJson(json['shop_invoice_list'])
        : null;
  }
}

class ShopInvoiceList {
  int? id;
  String? invoiceLink;

  ShopInvoiceList({
    required this.id,
    required this.invoiceLink,
  });
  ShopInvoiceList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    invoiceLink = json["invoice_link"];
  }
}
