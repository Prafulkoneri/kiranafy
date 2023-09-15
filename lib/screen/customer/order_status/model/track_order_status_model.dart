import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';

////////////////////////REQUEST Model//////////////////

class TrackOrderRequestodel {
  String? orderId;

  TrackOrderRequestodel({
    this.orderId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["order_id"] = orderId;
    return data;
  }
}

///////////////////////Response Model////////////////////////////////////
class TrackOrderResModel {
  int? status;
  String? message;
  TrackData? trackData;

  TrackOrderResModel({
    required this.status,
    required this.message,
    required this.trackData,
  });
  TrackOrderResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    trackData = json['data'] != null ? TrackData.fromJson(json['data']) : null;
  }
}

class TrackData {
  TrackOrderDetails? trackOrderDetails;
  ShopDetails? shopDetails;
  DeliveryAddressDetails? deliveryAddressDetails;

  TrackData({
    required this.trackOrderDetails,
    required this.shopDetails,
    required this.deliveryAddressDetails,
  });
  TrackData.fromJson(Map<String, dynamic> json) {
    trackOrderDetails = json['track_order_details'] != null
        ? TrackOrderDetails.fromJson(json['track_order_details'])
        : null;

    shopDetails = json['shop_details'] != null
        ? ShopDetails.fromJson(json['shop_details'])
        : null;

    deliveryAddressDetails = json['delivery_address_details'] != null
        ? DeliveryAddressDetails.fromJson(json['delivery_address_details'])
        : null;
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

class TrackOrderDetails {
  String? orderStatus;
  String? orderPlacedDateAndTime;
  String? orderConfirmedDateAndTime;
  String? orderPackingDateAndTime;
  String? orderDispatchedDateAndTime;
  String? orderDeliveredDateAndTime;
  String? orderCancelledDateAndTime;
  String? deliveryType;

  TrackOrderDetails({
    required this.orderStatus,
    required this.orderPlacedDateAndTime,
    required this.orderConfirmedDateAndTime,
    required this.orderPackingDateAndTime,
    required this.orderDispatchedDateAndTime,
    required this.orderDeliveredDateAndTime,
    required this.orderCancelledDateAndTime,
    required this.deliveryType,
  });
  TrackOrderDetails.fromJson(Map<String, dynamic> json) {
    orderStatus = json["order_status"];
    orderPlacedDateAndTime = json["order_placed_date_and_time"];
    orderConfirmedDateAndTime = json["order_confirmed_date_and_time"];
    orderPackingDateAndTime = json["order_packing_date_and_time"];
    orderDispatchedDateAndTime = json["order_dispatched_date_and_time"];
    orderDeliveredDateAndTime = json["order_delivered_date_and_time"];
    orderCancelledDateAndTime = json["order_cancelled_date_and_time"];
    deliveryType = json["delivery_type"];
  }
}
