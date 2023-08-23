import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:local_supper_market/screen/customer/cart/model/add_product_to_cart_model.dart';
import 'package:local_supper_market/screen/customer/cart/repository/add_product_to_cart_repo.dart';
import 'package:local_supper_market/screen/customer/delivery_address/view/add_address_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/add_fav_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/remove_fav_shop_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/add_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/remove_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/order_payment/view/order_payment_view.dart';
import 'package:local_supper_market/screen/customer/order_summary/model/c_apply_coupon_model.dart';
import 'package:local_supper_market/screen/customer/order_summary/model/order_summary_model.dart';
import 'package:local_supper_market/screen/customer/order_summary/model/remove_coupon_model.dart';
import 'package:local_supper_market/screen/customer/order_summary/repository/apply_coupon_repo.dart';
import 'package:local_supper_market/screen/customer/order_summary/repository/order_summary_repo.dart';
import 'package:local_supper_market/screen/customer/order_summary/repository/remove_coupon_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/remove_item_cart_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/repository/remove_item_from_cart_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class OrderSummaryController extends ChangeNotifier {
  OrderSummaryRepo orderSummaryRepo = OrderSummaryRepo();
  RemoveFavShopRepo removeFavShopRepo = RemoveFavShopRepo();
  AddFavShopRepo addFavShopRepo = AddFavShopRepo();
  AddProductToCartRepo addProductToCartRepo = AddProductToCartRepo();
  ApplyCouponRepo applyCouponRepo = ApplyCouponRepo();
  RemoveCouponRepo removeCouponRepo = RemoveCouponRepo();

  AddFavReqModel get addFavReqModel => AddFavReqModel(
        shopId: shopId.toString(),
      );
  RemoveFavReqModel get removeFavReqModel => RemoveFavReqModel(
        shopId: shopId.toString(),
      );
  TextEditingController expectedDateController = TextEditingController();
  String shopId = "";
  String cartId = "";
  String groupValue = "";
  String discountPercentage = "";
  List<bool> viewMore = [];
  ShopDetails? shopDetailData;
  ShopDeliveryTypes? shopDeliveryTypes;
  List? shopDeliverySlots;
  OrderFinalTotals? orderFinalTotals;
  List<CustomerAddress>? customerAddress;
  List<CartItemList>? cartItemList;
  List<FinalCouponList>? finalCouponList;
  List<FullFillYourCraving>? fullFillYourCravings;
  bool isLoading = true;
  bool isStackLoaderVisible = false;
  bool favAllShop = true;
  String slotGroupValue = "";
  String offerGroupValue = "";
  String addressGroupValue = "";
  bool isNotFilled = false;
  bool isExpectedDeliverySlotNotAvailable = false;
  String deliverySlotErrorMsg = "";
  String couponDiscount = "";
  String deliveryCharges = "";
  String productTotalDiscount = "";
  String subTotal = "";
  String totalAmount = "";
  String selfPickupTotalAmount = "";
  String selfPickupDeliveryCharges = "";
  String totalDiscount = "";
  String customerPickup = "";
  TextEditingController couponCodeController = TextEditingController();
  int selectedAddressId = 0;
  List<bool> isFulFilProductAdded = [];
  Future<void> initState(
    context,
    cId,
    id,
    refresh,
    route,
  ) async {
    // if(route=="addAddress"||route=="editAddress"){
    //    groupValue="delivery_to";
    // }
    print("fsfsdfsdfsdf");
    print(route);

    if (refresh) {
      if (customerPickup == "active" && route == "addAddress") {
        groupValue = "self_pickup";
      } else {
        groupValue = "delivery_to";
      }
      await getOrderSummary(context, cId, id, route);
    }

    notifyListeners();
  }

  void showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  void showOnPageLoader(value) {
    isStackLoaderVisible = value;
    notifyListeners();
  }

  void onExpectedDateSelected(value) {
    expectedDateController.text = value;
    notifyListeners();
  }

  void onRadioButtonSelected(value, context) {
    groupValue = value;
    if (groupValue == "delivery_to" && customerAddress!.isEmpty) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => MainScreenView(
                index: 4,
                screenName: AddAddressView(
                  shopId: shopDetailData?.id.toString(),
                  cartId: cartId,
                  route: "orderAddAddress",
                  isEditAdress: false,
                ))),
        (Route<dynamic> route) => false,
      );
    }
    if (groupValue == "self_pickup") {
      selfPickupTotalAmount =
          (int.parse(totalAmount) - int.parse(deliveryCharges)).toString();
      selfPickupDeliveryCharges = "0";
    }
    notifyListeners();
  }

  void onDeliverySlotSelected(value) {
    checkDeliverySlotAccodringToDate(value);

    notifyListeners();
  }

  void onOfferSelected(value, context, discount) async {
    offerGroupValue = value.toString();
    couponDiscount = discount;
    await applyCoupon(context);
    notifyListeners();
  }

  void onAddressSelected(value) {
    addressGroupValue = value;
    notifyListeners();
  }

  OrderSummaryReqModel get orderSummeryRequestModel =>
      OrderSummaryReqModel(shopId: shopId, cartId: cartId);

  Future<void> getOrderSummary(context, id, cId, route) async {
    if (route == 'cartDetail') {
      expectedDateController.clear();
      slotGroupValue = "";
      discountPercentage = "";
      offerGroupValue = "";
      couponCodeController.clear();
    }
    showLoader(true);
    shopId = id.toString();
    cartId = cId.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    orderSummaryRepo
        .viewOrderSummery(
            orderSummeryRequestModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = OrderSummaryResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        shopDeliveryTypes = result.orderSummaryData?.shopDeliveryTypes;
        customerPickup = result
                .orderSummaryData?.shopDeliveryTypes?.shopOwnerCustomerPickup ??
            "";

        shopDetailData = result.orderSummaryData?.shopDetails;
        shopDeliverySlots = result.orderSummaryData?.shopDeliverySlots;
        favAllShop = shopDetailData?.shopFavourite == "yes" ? true : false;
        expectedDateController.text =
            DateFormat('dd-MM-yyy').format(DateTime.now());

        // if(slotGroupValue==""){
        //   slotGroupValue=shopDeliverySlots?[0];
        // }
        //
        // if(currentHour<15){
        //   slotGroupValue = shopDeliverySlots?[1];
        //   }
        //
        //
        //   if(currentHour<18){
        //     slotGroupValue = shopDeliverySlots?[2];
        // }
        //   if(currentHour<21){
        //     slotGroupValue = shopDeliverySlots?[3];
        //   }

        orderFinalTotals = result.orderSummaryData?.orderFinalTotals;
        deliveryCharges = orderFinalTotals?.deliveryCharges ?? "";
        totalAmount = orderFinalTotals?.total.toString() ?? "";
        if (groupValue != "") {
          if (result.orderSummaryData?.shopDeliveryTypes
                  ?.shopOwnerCustomerPickup ==
              "active") {
            groupValue = "self_pickup";
            print("heloo");
            print(totalAmount.toString());
            print((int.parse(totalAmount.toString()) -
                int.parse(deliveryCharges.toString())));
            selfPickupTotalAmount = (int.parse(totalAmount.toString()) -
                    int.parse(deliveryCharges.toString()))
                .toString();
            print("selfPickupTotalAmount${selfPickupTotalAmount}");
            selfPickupDeliveryCharges = "0";
          } else {
            groupValue = "delivery_to";
          }
        }

        productTotalDiscount =
            orderFinalTotals?.productTotalDiscount.toString() ?? "";
        subTotal = orderFinalTotals?.subTotal.toString() ?? "";

        totalDiscount = orderFinalTotals?.totalDiscount.toString() ?? "";
        customerAddress = result.orderSummaryData?.customerAddresses;
        int addressListLength = customerAddress?.length ?? 0;
        for (int i = 0; i < addressListLength; i++) {
          if (customerAddress?[i].deliveryAddressIsDefault == "yes") {
            addressGroupValue = customerAddress?[i].addressId.toString() ?? "";
          }
        }
        cartItemList = result.orderSummaryData?.cartItemList;
        finalCouponList = result.orderSummaryData?.finalCouponList;
        int couponListLength = finalCouponList?.length ?? 0;
        viewMore = List<bool>.filled(couponListLength, false);
        couponDiscount = orderFinalTotals?.couponDiscount.toString() ?? "";
        fullFillYourCravings = result.orderSummaryData?.fullFillYourCravings;
        //////////////////
        int fulfilcravingListLength = fullFillYourCravings?.length ?? 0;
        isFulFilProductAdded =
            List<bool>.filled(fulfilcravingListLength, false, growable: true);
        for (int i = 0; i < fulfilcravingListLength; i++) {
          if (fullFillYourCravings?[i].addToCartCheck == "yes") {
            isFulFilProductAdded.insert(i, true);
          } else {
            isFulFilProductAdded.insert(i, false);
          }
        }
        showLoader(false);

        int deliverySlotLength = shopDeliverySlots?.length ?? 0;

        if (groupValue == "delivery_to" && customerAddress!.isEmpty) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => MainScreenView(
                    index: 4,
                    screenName: AddAddressView(
                      shopId: shopDetailData?.id.toString(),
                      cartId: cartId,
                      route: "orderAddAddress",
                      isEditAdress: false,
                    ))),
            (Route<dynamic> route) => false,
          );
        }
        if (route == "addAddress" || route == "editAddress") {
          print("fsfsdfsfsfsdfdsfdfsdfsdfs");
          groupValue = "delivery_to";
          notifyListeners();
        }
        var currentHour = DateTime.now().hour;
        print(currentHour);
        for (int i = 0; i < deliverySlotLength; i++) {
          if (shopDeliverySlots?[i] == "shop_owner_slot_9_to_12") {
            if (currentHour <= 12) {
              slotGroupValue = "shop_owner_slot_9_to_12";
              return;
            }
          }
          if (shopDeliverySlots?[i] == "shop_owner_slot_12_to_3") {
            if (currentHour <= 15) {
              slotGroupValue = "shop_owner_slot_12_to_3";
              return;
            }
          }
          if (shopDeliverySlots?[i] == "shop_owner_slot_3_to_6") {
            if (currentHour <= 18) {
              slotGroupValue = "shop_owner_slot_3_to_6";
              return;
            }
          }
          if (shopDeliverySlots?[i] == "shop_owner_slot_6_to_9") {
            if (currentHour <= 21) {
              slotGroupValue = "shop_owner_slot_6_to_9";
              return;
            }
          }
        }
        notifyListeners();
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
      (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }

  void onViewMoreClicked(index) {
    viewMore[index] = true;
    notifyListeners();
  }

  /////////////////////

  void onFulFilCarvingsSelected(index) {
    isFulFilProductAdded[index] = true;
    notifyListeners();
  }

  void launchPhone(String mobNumber, context) async {
    var number = Uri.parse("tel:${mobNumber}");
    if (await canLaunchUrl(number)) {
      await launchUrl(number);
    } else {
      Utils.showPrimarySnackbar(context, "Unable to dial at the moment",
          type: SnackType.error);
    }
  }

  Future<void> removeAllShopFavList(context, id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    removeFavShopRepo
        .updateRemoveFavShop(removeFavReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = RemoveFavResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        favAllShop = false;
        print("hello");
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
        notifyListeners();
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
      (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }

//
  Future<void> updateAllShopFavList(context, id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    addFavShopRepo
        .updateAddFavShop(addFavReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = AddFavResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        favAllShop = true;
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
        notifyListeners();
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
      (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }

  Future<void> addToCart(pType, pId, sId, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    addProductToCartRepo
        .addProductToCart(
            AddProductToCartReqModel(
                productType: pType,
                productUnitId: pId.toString(),
                shopId: sId.toString(),
                quantity: "1"),
            pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result =
          AddProductToCartResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        initState(
          context,
          shopId,
          cartId,
          true,
          "cartDetail",
        );
        // isFulFilProductAdded[index] = false;
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
        notifyListeners();
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
      (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }

  CustomerApplyCouponsRequestModel get customerApplyCouponsRequestModel =>
      CustomerApplyCouponsRequestModel(
        shopId: shopId,
        couponId: offerGroupValue,
        cartId: cartId,
        couponDiscount: couponDiscount,
        deliveryCharges: orderFinalTotals?.deliveryCharges == ""
            ? "0"
            : orderFinalTotals?.deliveryCharges,
        productTotalDiscount: orderFinalTotals?.productTotalDiscount.toString(),
        subTotal: orderFinalTotals?.subTotal.toString(),
        total: orderFinalTotals?.subTotal.toString(),
        totalDiscount: orderFinalTotals?.totalDiscount.toString(),
      );

  Future<void> applyCoupon(context) async {
    showLoader(true);
    showOnPageLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    applyCouponRepo
        .applyCoupon(
            customerApplyCouponsRequestModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result =
          CustomerApplyCouponsResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        final data = result.applyCouponData;
        couponCodeController.text = data?.couponCode.toString() ?? "";
        deliveryCharges = double.parse(data?.deliveryCharges ?? "0").toString();
        selfPickupDeliveryCharges = "0";
        subTotal = double.parse(data?.subTotal ?? "0").toString() ?? "";
        couponDiscount =
            double.parse(data?.couponDiscount ?? "0").toString() ?? "";
        totalAmount = double.parse(data?.total ?? "0").toString();
        selfPickupTotalAmount =
            (double.parse(totalAmount) - double.parse(deliveryCharges))
                    .toString() ??
                "";
        totalDiscount =
            double.parse(data?.totalDiscount ?? "0").toString() ?? "";
        discountPercentage = data?.discountPercentage ?? "";
        showOnPageLoader(false);
        showLoader(false);
        Navigator.pop(context);
        notifyListeners();
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
      (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }

  CustomerRemoveCouponsRequestModel get customerRemoveCouponsRequestModel =>
      CustomerRemoveCouponsRequestModel(
        cartId: cartId,
        shopId: shopId,
      );

  Future<void> removeCoupon(context) async {
    if (couponCodeController.text == "") {
      Utils.showPrimarySnackbar(context, "No Coupon Added",
          type: SnackType.error);
      return;
    }
    showOnPageLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    removeCouponRepo
        .removeCoupon(
            customerRemoveCouponsRequestModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result =
          CustomerRemoveCouponsResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        final data = result.data;
        couponCodeController.clear();
        offerGroupValue = "";
        couponDiscount =
            data?.removeCouponData?.couponDiscount.toString() ?? "0";
        // deliveryCharges =
        //     data?.removeCouponData?.deliveryCharges.toString() ?? "";
        selfPickupDeliveryCharges = "0";
        subTotal = data?.removeCouponData?.subTotal.toString() ?? "";
        totalAmount = data?.removeCouponData?.total.toString() ?? "";
        selfPickupTotalAmount =
            (double.parse(totalAmount) - double.parse(deliveryCharges))
                .toString();
        totalDiscount = data?.removeCouponData?.totalDiscount.toString() ?? "";
        discountPercentage = "";
        showOnPageLoader(false);
        notifyListeners();
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
      (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }

  void onConfirmOrder(context) {
    if (expectedDateController.text == "") {
      Utils.showPrimarySnackbar(context, "Select Expected Date",
          type: SnackType.error);
      return;
    }
    if (slotGroupValue == "") {
      Utils.showPrimarySnackbar(context, "Select Slot", type: SnackType.error);
      return;
    }
    if (customerAddress!.isEmpty && groupValue == "delivery_to") {
      Utils.showPrimarySnackbar(context, "Add an address",
          type: SnackType.error);
      return;
    }
    showOnPageLoader(true);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => OrderPaymentView(
                cartId: cartId.toString(),
                shopId: shopId.toString(),
                couponId: offerGroupValue.toString(),
                customerDeliveryAddressId: addressGroupValue,
                customerDeliveryDate: expectedDateController.text,
                customerDeliverySlot: slotGroupValue,
                customerDeliveryType: groupValue,
                finalDeliveryCharges: groupValue == "self_pickup"
                    ? selfPickupDeliveryCharges
                    : deliveryCharges == ""
                        ? "0"
                        : deliveryCharges,
                finalSubTotal: subTotal,
                finalTotalAmount: groupValue == "self_pickup"
                    ? selfPickupTotalAmount
                    : totalAmount,
                finalTotalDiscount: totalDiscount,
                totalItems: orderFinalTotals?.itemCount.toString(),
              )),
    );
    showOnPageLoader(false);
  }

  void updateCartId(value) {
    cartId = value;
    notifyListeners();
  }

  void checkDeliverySlotAccodringToDate(timeSlot) async {
    var currentDate = DateFormat('dd-MM-yyy').format(DateTime.now());
    if (expectedDateController.text == currentDate) {
      var currentHour = DateTime.now().hour;
      if (timeSlot == "shop_owner_slot_9_to_12") {
        print("hello");
        print(currentHour);
        if (currentHour >= 12) {
          isExpectedDeliverySlotNotAvailable = true;
          Timer(Duration(seconds: 3), () {
            isExpectedDeliverySlotNotAvailable = false;
            notifyListeners();
          });

          deliverySlotErrorMsg = "This time slot cannot be selected";
          return;
        }
      }
      if (timeSlot == "shop_owner_slot_12_to_3") {
        if (currentHour >= 15) {
          isExpectedDeliverySlotNotAvailable = true;
          Timer(Duration(seconds: 3), () {
            isExpectedDeliverySlotNotAvailable = false;
            notifyListeners();
          });
          deliverySlotErrorMsg = "This time slot cannot be selected";
          return;
        }
      }
      if (timeSlot == "shop_owner_slot_3_to_6") {
        print("hiii");
        print(currentHour);
        if (currentHour >= 18) {
          isExpectedDeliverySlotNotAvailable = true;
          Timer(Duration(seconds: 3), () {
            isExpectedDeliverySlotNotAvailable = false;
            notifyListeners();
          });
          deliverySlotErrorMsg = "This time slot cannot be selected";
          return;
        }
      }
      if (timeSlot == "shop_owner_slot_6_to_9") {
        if (currentHour >= 21) {
          isExpectedDeliverySlotNotAvailable = true;
          Timer(Duration(seconds: 3), () {
            isExpectedDeliverySlotNotAvailable = false;
            notifyListeners();
          });
          deliverySlotErrorMsg = "This time slot cannot be selected";
          return;
        }
      }
    }
    slotGroupValue = timeSlot;
    notifyListeners();
  }

  void onDismiss() {
    isExpectedDeliverySlotNotAvailable = false;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////
  RemoveCartItemRepo removeCartItemRepo = RemoveCartItemRepo();
  Future<void> removeFromCart(pType, puId, sId, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    removeCartItemRepo
        .removeCartItem(
            RemoveItemFromCartReq(
                productType: pType.toString(),
                productUnitId: puId.toString(),
                shopId: sId.toString(),
                quantity: "0"),
            pref.getString("successToken"))
        .then((response) async {
      log("response.body${response.body}");
      final result =
          CartRemoveResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        initState(
          context,
          shopId,
          cartId,
          true,
          "cartDetail",
        );
        // isFulFilProductAdded[index] = false;
        // await getAllOfferes(context, sId);
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
        notifyListeners();
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
      (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }
}
