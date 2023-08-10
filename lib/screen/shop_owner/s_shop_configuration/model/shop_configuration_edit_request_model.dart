class ShopConfigRequestModel {
  String? shopOwnerPaymentQrCodeImagePath;
  String? shopOwnerPaymentQrCodeImageName;
  String? shopOwnerSupportNumber;
  String? shopOwnerShopOpeningTime;
  String? shopOwnerShopCloseTime;
  String? shopOwnerAmount1DeliveryCharges;
  String? shopOwnerAmount2DeliveryCharges;
  String? shopOwnerAmount3DeliveryCharges;
  String? shopOwnerAmount4DeliveryCharges;
  String? shopOwnerCustomerPickup;
  String? shopOwnerDeliveryToCustomer;
  String? shopOwnerDeliveryChargesFree;
  String? shopOwnerSlot9To12;
  String? shopOwnerSlot12To3;
  String? shopOwnerSlot3To6;
  String? shopOwnerSlot6To9;
  String? shopOwnerUpiId;
  String? acceptedPaymentStatus;
  String? minimumOrderDeliveryAmount;
  String ? areaId;

  ShopConfigRequestModel({
    required this.shopOwnerPaymentQrCodeImagePath,
    required this.shopOwnerPaymentQrCodeImageName,
    required this.shopOwnerSupportNumber,
    required this.shopOwnerShopOpeningTime,
    required this.shopOwnerShopCloseTime,
    required this.shopOwnerAmount1DeliveryCharges,
    required this.shopOwnerAmount2DeliveryCharges,
    required this.shopOwnerAmount3DeliveryCharges,
    required this.shopOwnerAmount4DeliveryCharges,
    required this.shopOwnerCustomerPickup,
    required this.shopOwnerDeliveryToCustomer,
    required this.shopOwnerDeliveryChargesFree,
    required this.shopOwnerSlot9To12,
    required this.shopOwnerSlot12To3,
    required this.shopOwnerSlot3To6,
    required this.shopOwnerSlot6To9,
    required this.shopOwnerUpiId,
    required this.acceptedPaymentStatus,
    required this.minimumOrderDeliveryAmount,
    required this.areaId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["shop_owner_payment_qr_code_image_path"] =
        shopOwnerPaymentQrCodeImagePath;
    data["shop_owner_payment_qr_code_image_name"] =
        shopOwnerPaymentQrCodeImageName;
    data["shop_owner_support_number"] = shopOwnerSupportNumber;
    data["shop_owner_shop_opening_time"] = shopOwnerShopOpeningTime;
    data["shop_owner_shop_close_time"] = shopOwnerShopCloseTime;
    data["shop_owner_amount_1_delivery_charges"] =
        shopOwnerAmount1DeliveryCharges;
    data["shop_owner_amount_2_delivery_charges"] =
        shopOwnerAmount2DeliveryCharges;
    data["shop_owner_amount_3_delivery_charges"] =
        shopOwnerAmount3DeliveryCharges;
    data["shop_owner_amount_4_delivery_charges"] =
        shopOwnerAmount4DeliveryCharges;
    data["shop_owner_customer_pickup"] = shopOwnerCustomerPickup;
    data["shop_owner_delivery_to_customer"] = shopOwnerDeliveryToCustomer;
    data["shop_owner_delivery_charges_free"] = shopOwnerDeliveryChargesFree;
    data["shop_owner_slot_9_to_12"] = shopOwnerSlot9To12;
    data["shop_owner_slot_12_to_3"] = shopOwnerSlot12To3;
    data["shop_owner_slot_3_to_6"] = shopOwnerSlot3To6;
    data["shop_owner_slot_6_to_9"] = shopOwnerSlot6To9;
    data["shop_owner_upi_id"] = shopOwnerUpiId;
    data['accepted_payment_status'] = acceptedPaymentStatus;
    data['min_order_amount_for_delivery'] = minimumOrderDeliveryAmount;
    data['area_id'] = areaId;

    return data;
  }
}

////Response Model
class ShopConfigurationRes {
  int? status;
  String? message;

  ShopConfigurationRes({
    required this.status,
    required this.message,
  });

  ShopConfigurationRes.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}

class DeliverAreaList{

}
