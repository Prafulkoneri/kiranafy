import '../../shop_profile/model/customer_view_shop_model.dart';

////////Request Model////////////////
class OrderSummaryReqModel {
  String? cartId;
  String? shopId;

  OrderSummaryReqModel({
    this.cartId,
    this.shopId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["cart_id"] = cartId;
    data["shop_id"] = shopId;
    return data;
  }
}

///////////////////Response Model/////////////////
class OrderSummaryResModel {
  int? status;
  String? message;
  OrderSummaryData? orderSummaryData;

  OrderSummaryResModel({
    required this.status,
    required this.message,
    required this.orderSummaryData,
  });

  OrderSummaryResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    orderSummaryData =
        json['data'] != null ? OrderSummaryData.fromJson(json['data']) : null;
  }
}

class OrderSummaryData {
  ShopDetails? shopDetails;
  ShopDeliveryTypes? shopDeliveryTypes; //
  List? shopDeliverySlots; //
  List<CustomerAddress>? customerAddresses; //
  List<CartItemList>? cartItemList; //
  OrderFinalTotals? orderFinalTotals; //
  List<FinalCouponList>? finalCouponList; //
  List<FullFillYourCraving>? fullFillYourCravings;

  OrderSummaryData({
    required this.shopDetails,
    required this.shopDeliveryTypes,
    required this.shopDeliverySlots,
    required this.customerAddresses,
    required this.cartItemList,
    required this.orderFinalTotals,
    required this.finalCouponList,
    required this.fullFillYourCravings,
  });
  OrderSummaryData.fromJson(Map<String, dynamic> json) {
    shopDetails = json['shop_details'] != null
        ? ShopDetails.fromJson(json['shop_details'])
        : null;
    //Delivery Type
    shopDeliveryTypes = json['shop_delivery_types'] != null
        ? ShopDeliveryTypes.fromJson(json['shop_delivery_types'])
        : null;

    ///Delivery Slot
    if (json["shop_delivery_slots"] != null) {
      shopDeliverySlots = [];
      json["shop_delivery_slots"].forEach((v) {
        shopDeliverySlots!.add(v);
      });
    }
/////Customer Address//////
    if (json["customer_addresses"] != null) {
      customerAddresses = <CustomerAddress>[];
      json["customer_addresses"].forEach((v) {
        customerAddresses!.add(CustomerAddress.fromJson(v));
      });
    }
    ////Cart Item List///////////
    if (json["cart_item_list"] != null) {
      cartItemList = <CartItemList>[];
      json["cart_item_list"].forEach((v) {
        cartItemList!.add(CartItemList.fromJson(v));
      });
    }
    ///////Order Final Totals/////
    orderFinalTotals = json['order_final_totals'] != null
        ? OrderFinalTotals.fromJson(json['order_final_totals'])
        : null;
    /////////////Final Coupon List/////
    if (json["final_coupon_list"] != null) {
      finalCouponList = <FinalCouponList>[];
      json["final_coupon_list"].forEach((v) {
        finalCouponList!.add(FinalCouponList.fromJson(v));
      });
    }

    ///////full_fill_your_cravings//////////
    if (json["full_fill_your_cravings"] != null) {
      fullFillYourCravings = <FullFillYourCraving>[];
      json["full_fill_your_cravings"].forEach((v) {
        fullFillYourCravings!.add(FullFillYourCraving.fromJson(v));
      });
    }
  }
}

class CartItemList {
  String? productName;
  String? productImagePath;
  String? productImageName;
  int? quantity;
  String? weight;
  String? unit;
  String? offerPrice;
  String? mrpPrice;
  int? productTotalPrice;
  String? productType;

  CartItemList({
    required this.productName,
    required this.productImagePath,
    required this.productImageName,
    required this.quantity,
    required this.weight,
    required this.unit,
    required this.offerPrice,
    required this.mrpPrice,
    required this.productTotalPrice,
    required this.productType,
  });
  CartItemList.fromJson(Map<String, dynamic> json) {
    productName = json["product_name"];
    productImagePath = json["product_image_path"];
    productImageName = json["product_image_name"];
    quantity = json["quantity"];
    weight = json["weight"];
    unit = json["unit"];
    offerPrice = json["offer_price"];
    mrpPrice = json["mrp_price"];
    productTotalPrice = json["product_total_price"];
    productType = json["product_type"];
  }
}

class CustomerAddress {
  int? addressId;
  String? customerName;
  String? mobileNo;
  String? deliveryAddressType;
  String? deliveryAddressIsDefault;
  String? address1;
  String? address2;

  CustomerAddress({
    required this.addressId,
    required this.customerName,
    required this.mobileNo,
    required this.deliveryAddressType,
    required this.deliveryAddressIsDefault,
    required this.address1,
    required this.address2,
  });
  CustomerAddress.fromJson(Map<String, dynamic> json) {
    addressId = json["address_id"];
    customerName = json["customer_name"];
    mobileNo = json["mobile_no"];
    deliveryAddressType = json["delivery_address_type"];
    deliveryAddressIsDefault = json["delivery_address_is_default"];
    address1 = json["address_1"];
    address2 = json["address_2"];
  }
}

class FullFillYourCraving {
  int? id;
  String? productName;
  String? productImagePath;
  String? productImageName;
  int? productUnitId;
  String? weight;
  String? offerPrice;
  String? mrpPrice;
  int? categoryId;
  String? productType;
  String? shopId;
  String? discountPercentage;
  int? productId;
  String? status;
  String? unit;

  FullFillYourCraving({
    required this.id,
    required this.productName,
    required this.productImagePath,
    required this.productImageName,
    required this.productUnitId,
    required this.weight,
    required this.offerPrice,
    required this.mrpPrice,
    required this.categoryId,
    required this.productType,
    required this.shopId,
    required this.discountPercentage,
    required this.productId,
    required this.status,
    required this.unit,
  });

  FullFillYourCraving.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productName = json["product_name"];
    productImagePath = json["product_image_path"];
    productImageName = json["product_image_name"];
    productUnitId = json["product_unit_id"];
    weight = json["weight"];
    offerPrice = json["offer_price"];
    mrpPrice = json["mrp_price"];
    categoryId = json["category_id"];
    productType = json["product_type"];
    shopId = json["shop_id"];
    discountPercentage = json["discount_percentage"];
    productId = json["product_id"];
    status = json["status"];
    unit = json["unit"];
  }
}

class OrderFinalTotals {
  int? subTotal;
  int? couponDiscount;
  int? totalDiscount;
  int? productTotalDiscount;
  String? deliveryCharges;
  int ? itemCount;
  int? total;

  OrderFinalTotals({
    required this.subTotal,
    required this.couponDiscount,
    required this.totalDiscount,
    required this.productTotalDiscount,
    required this.deliveryCharges,
    required this.total,
    required this.itemCount,
  });
  OrderFinalTotals.fromJson(Map<String, dynamic> json) {
    subTotal = json["sub_total"];
    couponDiscount = json["coupon_discount"];
    totalDiscount = json["total_discount"];
    productTotalDiscount = json["product_total_discount"];
    deliveryCharges = json["delivery_charges"];
    total = json["total"];
    itemCount = json["total_items_in_cart"];
  }
}

class ShopDeliverySlots {
  String? shopOwnerSlot9To12;
  String? shopOwnerSlot12To3;
  String? shopOwnerSlot3To6;
  String? shopOwnerSlot6To9;

  ShopDeliverySlots({
    required this.shopOwnerSlot9To12,
    required this.shopOwnerSlot12To3,
    required this.shopOwnerSlot3To6,
    required this.shopOwnerSlot6To9,
  });
  ShopDeliverySlots.fromJson(Map<String, dynamic> json) {
    shopOwnerSlot9To12 = json["shop_owner_slot_9_to_12"];
    shopOwnerSlot12To3 = json["shop_owner_slot_12_to_3"];
    shopOwnerSlot3To6 = json["shop_owner_slot_3_to_6"];
    shopOwnerSlot6To9 = json["shop_owner_slot_6_to_9"];
  }
}

class ShopDeliveryTypes {
  String? shopOwnerCustomerPickup;
  String? shopOwnerDeliveryToCustomer;
  String? shopOwnerDeliveryChargesFree;

  ShopDeliveryTypes({
    required this.shopOwnerCustomerPickup,
    required this.shopOwnerDeliveryToCustomer,
    required this.shopOwnerDeliveryChargesFree,
  });
  ShopDeliveryTypes.fromJson(Map<String, dynamic> json) {
    shopOwnerCustomerPickup = json["shop_owner_customer_pickup"];
    shopOwnerDeliveryToCustomer = json["shop_owner_delivery_to_customer"];
    shopOwnerDeliveryChargesFree = json["shop_owner_delivery_charges_free"];
  }
}

class FinalCouponList {
  int? id;
  String? couponCode;
  String ? couponTermsAndCondition;
  String? couponDiscountPercentage;
  String? couponDiscountMaxAmount;

  FinalCouponList({
    required this.id,
    required this.couponCode,
    required this.couponTermsAndCondition,
    required this.couponDiscountMaxAmount,
    required this.couponDiscountPercentage,
  });
  FinalCouponList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    couponCode = json["coupon_code"];
    couponDiscountPercentage = json["coupon_discount_percentage"];
    couponDiscountMaxAmount = json["coupon_discount_max_amount"];
    couponTermsAndCondition = json["coupon_terms_and_conditions"];
  }
}

// class ShopDetails {
//   int id;
//   String shopName;
//   String shopAddress;
//   String areaName;
//   String cityName;
//   int shopPincode;
//   String shopOwnerSupportNumber;

//   ShopDetails({
//     required this.id,
//     required this.shopName,
//     required this.shopAddress,
//     required this.areaName,
//     required this.cityName,
//     required this.shopPincode,
//     required this.shopOwnerSupportNumber,
//   });
// }
