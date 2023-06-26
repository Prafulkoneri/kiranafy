class MyOrdersRequestModel {
  String? shopId; //
  String? orderStatus;

  MyOrdersRequestModel({this.shopId, this.orderStatus});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data["shop_id"] = shopId;
    data["order_status"] = orderStatus;
    return data;
  }
}

///////////////////RESPONSE MODEL///////////////////////
class MyOrdersResponseModel {
  int? status;
  String? message;
  MyOrdersData? myOrdersData;

  MyOrdersResponseModel({
    required this.status,
    required this.message,
    required this.myOrdersData,
  });
  MyOrdersResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    myOrdersData =
        json['data'] != null ? MyOrdersData.fromJson(json['data']) : null;
  }
}

class MyOrdersData {
  List<OrderList>? orderList;
  List<OrderedShopsList>? orderedShopsList;

  MyOrdersData({
    required this.orderList,
    required this.orderedShopsList,
  });
  MyOrdersData.fromJson(Map<String, dynamic> json) {
    if (json["order_list"] != null) {
      orderList = <OrderList>[];
      json["order_list"].forEach((v) {
        orderList!.add(OrderList.fromJson(v));
      });
    }

    if (json["ordered_shops_list"] != null) {
      orderedShopsList = <OrderedShopsList>[];
      json["ordered_shops_list"].forEach((v) {
        orderedShopsList!.add(OrderedShopsList.fromJson(v));
      });
    }
  }
}

class OrderList {
  int? id;
  String? orderUniqueId;
  String? orderStatus;
  String? createdAt;
  String? totalAmount;
  String? totalItems;

  OrderList({
    required this.id,
    required this.orderUniqueId,
    required this.orderStatus,
    required this.createdAt,
    required this.totalAmount,
    required this.totalItems,
  });
  OrderList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    orderUniqueId = json["order_unique_id"];
    orderStatus = json["order_status"];
    createdAt = json["created_at"];
    totalAmount = json["total_amount"];
    totalItems = json["total_items"];
  }
}

class OrderedShopsList {
  int? id;
  String? shopName;

  OrderedShopsList({
    required this.id,
    required this.shopName,
  });
  OrderedShopsList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    shopName = json["shop_name"];
  }
}
