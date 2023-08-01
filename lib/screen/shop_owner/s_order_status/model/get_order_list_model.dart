class SGetOrderListModel {
  int? status;
  String? message;
  ShopOrderListData? shopOrderList;

  SGetOrderListModel({
    required this.status,
    required this.message,
    required this.shopOrderList,
  });
  SGetOrderListModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    shopOrderList =
        json['data'] != null ? ShopOrderListData.fromJson(json['data']) : null;
  }
}

class ShopOrderListData {
  List<ShopOrderList>? pendingOrdersList;
  List<ShopOrderList>? confirmedOrdersList;
  List<ShopOrderList>? inprocessOrdersList;
  List<ShopOrderList>? deliveredOrdersList;
  List<ShopOrderList>? cancelledOrdersList;

  ShopOrderListData({
    required this.pendingOrdersList,
    required this.confirmedOrdersList,
    required this.inprocessOrdersList,
    required this.deliveredOrdersList,
    required this.cancelledOrdersList,
  });
  ShopOrderListData.fromJson(Map<String, dynamic> json) {
    if (json["pending_orders_list"] != null) {
      pendingOrdersList = <ShopOrderList>[];
      json["pending_orders_list"].forEach((v) {
        pendingOrdersList!.add(ShopOrderList.fromJson(v));
      });
    }

    ///
    if (json["confirmed_orders_list"] != null) {
      confirmedOrdersList = <ShopOrderList>[];
      json["confirmed_orders_list"].forEach((v) {
        confirmedOrdersList!.add(ShopOrderList.fromJson(v));
      });
    }

    ///
    if (json["inprocess_orders_list"] != null) {
      inprocessOrdersList = <ShopOrderList>[];
      json["inprocess_orders_list"].forEach((v) {
        inprocessOrdersList!.add(ShopOrderList.fromJson(v));
      });
    }

    ///
    if (json["delivered_orders_list"] != null) {
      deliveredOrdersList = <ShopOrderList>[];
      json["delivered_orders_list"].forEach((v) {
        deliveredOrdersList!.add(ShopOrderList.fromJson(v));
      });
    }

    ///
    if (json["cancelled_orders_list"] != null) {
      cancelledOrdersList = <ShopOrderList>[];
      json["cancelled_orders_list"].forEach((v) {
        cancelledOrdersList!.add(ShopOrderList.fromJson(v));
      });
    }
  }
}

class ShopOrderList {
  int? id;
  String? customerName;
  String? orderUniqueId;
  String? totalItems;
  String? totalAmount;
  String? createdAt;

  ShopOrderList({
    required this.id,
    required this.customerName,
    required this.orderUniqueId,
    required this.totalItems,
    required this.totalAmount,
    required this.createdAt,
  });
  ShopOrderList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    customerName = json["customer_name"];
    orderUniqueId = json["order_unique_id"];
    totalItems = json["total_items"];
    totalAmount = json["total_amount"];
    createdAt = json["created_at"];
  }
}

// class ConfiremOrderList {
//   int? id;
//   String? customerName;
//   String? orderUniqueId;
//   String? totalItems;
//   String? totalAmount;
//   String? createdAt;

//   ConfiremOrderList({
//     required this.id,
//     required this.customerName,
//     required this.orderUniqueId,
//     required this.totalItems,
//     required this.totalAmount,
//     required this.createdAt,
//   });
//    ConfiremOrderList.fromJson(Map<String, dynamic> json) {
//     id = json["id"];
//     customerName = json["customer_name"];
//     orderUniqueId = json["order_unique_id"];
//     totalItems = json["total_items"];
//     totalAmount = json["total_amount"];
//     createdAt = json["created_at"];
//   }
// }

// class InprocessOrderList {
//   int? id;
//   String? customerName;
//   String? orderUniqueId;
//   String? totalItems;
//   String? totalAmount;
//   String? createdAt;

//   InprocessOrderList({
//     required this.id,
//     required this.customerName,
//     required this.orderUniqueId,
//     required this.totalItems,
//     required this.totalAmount,
//     required this.createdAt,
//   });
//    InprocessOrderList.fromJson(Map<String, dynamic> json) {
//     id = json["id"];
//     customerName = json["customer_name"];
//     orderUniqueId = json["order_unique_id"];
//     totalItems = json["total_items"];
//     totalAmount = json["total_amount"];
//     createdAt = json["created_at"];
//   }
// }

// class DeliveryOrderList {
//   int? id;
//   String? customerName;
//   String? orderUniqueId;
//   String? totalItems;
//   String? totalAmount;
//   String? createdAt;

//   DeliveryOrderList({
//     required this.id,
//     required this.customerName,
//     required this.orderUniqueId,
//     required this.totalItems,
//     required this.totalAmount,
//     required this.createdAt,
//   });
//    DeliveryOrderList.fromJson(Map<String, dynamic> json) {
//     id = json["id"];
//     customerName = json["customer_name"];
//     orderUniqueId = json["order_unique_id"];
//     totalItems = json["total_items"];
//     totalAmount = json["total_amount"];
//     createdAt = json["created_at"];
//   }
// }

// class CancellOrderList {
//   int? id;
//   String? customerName;
//   String? orderUniqueId;
//   String? totalItems;
//   String? totalAmount;
//   String? createdAt;

//   CancellOrderList({
//     required this.id,
//     required this.customerName,
//     required this.orderUniqueId,
//     required this.totalItems,
//     required this.totalAmount,
//     required this.createdAt,
//   });
//    CancellOrderList.fromJson(Map<String, dynamic> json) {
//     id = json["id"];
//     customerName = json["customer_name"];
//     orderUniqueId = json["order_unique_id"];
//     totalItems = json["total_items"];
//     totalAmount = json["total_amount"];
//     createdAt = json["created_at"];
//   }
// }
