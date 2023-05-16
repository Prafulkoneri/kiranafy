class ShopConfigurationResponse {
  int? status;
  String? message;
  Data? data;

  ShopConfigurationResponse({
    required this.status,
    required this.message,
    required this.data,
  });
  ShopConfigurationResponse.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];

    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
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

  Data({
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
  });

  Data.fromJson(Map<String, dynamic> json) {
    shopOwnerPaymentQrCodeImagePath =
        json['shop_owner_payment_qr_code_image_path'];
    shopOwnerPaymentQrCodeImageName =
        json['shop_owner_payment_qr_code_image_name'];
    shopOwnerSupportNumber = json['shop_owner_support_number'];
    shopOwnerShopOpeningTime = json['shop_owner_shop_opening_time'];
    shopOwnerShopCloseTime = json['shop_owner_shop_close_time'];
    shopOwnerShopCloseTime = json['shop_owner_shop_close_time'];
    shopOwnerAmount1DeliveryCharges =
        json['shop_owner_amount_1_delivery_charges'];
    shopOwnerAmount2DeliveryCharges =
        json['shop_owner_amount_2_delivery_charges'];
    shopOwnerAmount3DeliveryCharges =
        json['shop_owner_amount_3_delivery_charges'];
    shopOwnerAmount4DeliveryCharges =
        json['shop_owner_amount_4_delivery_charges'];
    shopOwnerCustomerPickup = json['shop_owner_customer_pickup'];
    shopOwnerDeliveryToCustomer = json['shop_owner_delivery_to_customer'];
    shopOwnerDeliveryChargesFree = json['shop_owner_delivery_charges_free'];
    shopOwnerSlot9To12 = json['shop_owner_slot_9_to_12'];
    shopOwnerSlot12To3 = json['shop_owner_slot_12_to_3'];
    shopOwnerSlot3To6 = json['shop_owner_slot_3_to_6'];
    shopOwnerSlot6To9 = json['shop_owner_slot_6_to_9'];
    shopOwnerUpiId = json['shop_owner_upi_id'];
  }
}
