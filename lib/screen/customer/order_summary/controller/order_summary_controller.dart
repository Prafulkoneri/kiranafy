import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:local_supper_market/screen/customer/cart/model/add_product_to_cart_model.dart';
import 'package:local_supper_market/screen/customer/cart/model/cart_item_quantity_model.dart';
import 'package:local_supper_market/screen/customer/cart/repository/add_product_to_cart_repo.dart';
import 'package:local_supper_market/screen/customer/cart/repository/cart_item_quantity_repo.dart';
import 'package:local_supper_market/screen/customer/delivery_address/view/add_address_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/add_fav_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/remove_fav_shop_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/add_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/remove_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/order_payment/view/order_payment_view.dart';
import 'package:local_supper_market/screen/customer/order_summary/model/c_apply_coupon_model.dart';
import 'package:local_supper_market/screen/customer/order_summary/model/fullfill_cravings_model.dart';
import 'package:local_supper_market/screen/customer/order_summary/model/order_summary_model.dart';
import 'package:local_supper_market/screen/customer/order_summary/model/remove_coupon_model.dart';
import 'package:local_supper_market/screen/customer/order_summary/repository/apply_coupon_repo.dart';
import 'package:local_supper_market/screen/customer/order_summary/repository/fullfill_your_cravings_repo.dart';
import 'package:local_supper_market/screen/customer/order_summary/repository/order_summary_repo.dart';
import 'package:local_supper_market/screen/customer/order_summary/repository/remove_coupon_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/remove_item_cart_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/repository/remove_item_from_cart_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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
  List<FullFillYourCraving> fullFillYourCravingsAdmin = [];
  List<FullFillYourCraving> fullFillYourCravingsCustom = [];

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
  int offset = 0;
  bool showPaginationLoader = false;
  String selfPickupDeliveryCharges = "";
  String totalDiscount = "";
  String customerPickup = "";
  TextEditingController couponCodeController = TextEditingController();
  int selectedAddressId = 0;
  // List<bool> isFulFilProductAdded = [];
  // List<bool> isFulFilProductAddedCustome = [];
  List<bool> isSlotAvailable = [];
  FullFillYourCravingsRepo fullFillYourCravingsRepo =
      FullFillYourCravingsRepo();
  String quantityAction = "";
  String cartItemId = "";
  String productType = "";
  bool isQuanityBtnPressed = false;
  List cartItemCustomeIdList = [];
  List cartItemAdminIdList = [];
  List quantityAdminList = [];
  List quantityCustomeList = [];
  CartItemQuantityRepo cartItemQuantityRepo = CartItemQuantityRepo();

  Future<void> initState(
    context,
    cId,
    id,
    refresh,
    route,
  ) async {
    cartItemAdminIdList.clear();
    cartItemCustomeIdList.clear();
    quantityAdminList.clear();
    quantityCustomeList.clear();
    // if(route=="addAddress"||route=="editAddress"){
    //    groupValue="delivery_to";
    // }
    print("fsfsdfsdfsdf");
    print(route);

    if (refresh) {
      fullFillYourCravingsAdmin.clear();
      fullFillYourCravingsCustom.clear();
      if (route != "orderSummary") {
        if (customerPickup == "active" && route == "addAddress") {
          groupValue = "self_pickup";
        } else {
          groupValue = "delivery_to";
        }
      }
      await getOrderSummary(context, cId, id, route);
      await getFullFillYourCravingsList(context);
    }

    notifyListeners();
  }

  showPaginationLoaderInApp(value) {
    showPaginationLoader = value;
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
    checkDeliveryDateAndSlot();
    notifyListeners();
  }

  void onRadioButtonSelected(value, context) {
    groupValue = value;
    if (groupValue == "delivery_to" && customerAddress!.isEmpty) {
      final read = Provider.of<MainScreenController>(context, listen: false);
      read.onNavigation(
          2,
          AddAddressView(
            shopId: shopDetailData?.id.toString(),
            cartId: cartId,
            route: "orderAddAddress",
            isEditAdress: false,
          ),
          context);
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => MainScreenView(
      //           index: 4,
      //           screenName: AddAddressView(
      //             shopId: shopDetailData?.id.toString(),
      //             cartId: cartId,
      //             route: "orderAddAddress",
      //             isEditAdress: false,
      //           ))),
      //   (Route<dynamic> route) => false,
      // );
    }
    if (groupValue == "self_pickup") {
      print(deliveryCharges);
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

  FullFillCravingsReqModel get fullFillCravingsReqModel =>
      FullFillCravingsReqModel(
          offset: offset.toString(), limit: "10", shopId: shopId);

  Future<void> getFullFillYourCravingsList(context) async {
    print("comeonnn");
    SharedPreferences pref = await SharedPreferences.getInstance();
    fullFillYourCravingsRepo
        .getFullYourCravingsList(
            fullFillCravingsReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result =
          FullFillCravingsResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        fullFillYourCravingsAdmin
            .addAll(result.data?.fullFillYourCravingsAdminProduct ?? []);
        fullFillYourCravingsCustom
            .addAll(result.data?.fullFillYourCravingsCustomProduct ?? []);
        int fulfilcravingListLength = fullFillYourCravingsAdmin.length ?? 0;
        // isFulFilProductAdded =
        //     List<bool>.filled(fulfilcravingListLength, false, growable: true);
        // for (int i = 0; i < fulfilcravingListLength; i++) {
        //   if (fullFillYourCravingsAdmin[i].addToCartCheck == "yes") {
        //     isFulFilProductAdded.insert(i, true);
        //   } else {
        //     isFulFilProductAdded.insert(i, false);
        //   }
        // }
        ///////////////////////
        for (int i = 0; i < fulfilcravingListLength; i++) {
          quantityAdminList
              .add(result.data?.fullFillYourCravingsAdminProduct?[i].quantity);
          cartItemAdminIdList.add(
              result.data?.fullFillYourCravingsAdminProduct?[i].cartItemId);
        }
        /////////////////////////
        int fulfilcravingListCustomeLength =
            fullFillYourCravingsCustom.length ?? 0;
        // isFulFilProductAddedCustome = List<bool>.filled(
        //     fulfilcravingListCustomeLength, false,
        //     growable: true);
        // for (int i = 0; i < fulfilcravingListCustomeLength; i++) {
        //   if (fullFillYourCravingsCustom[i].addToCartCheck == "yes") {
        //     isFulFilProductAddedCustome.insert(i, true);
        //   } else {
        //     isFulFilProductAddedCustome.insert(i, false);
        //   }
        // }
        //////////////////////////////////
        for (int i = 0; i < fulfilcravingListCustomeLength; i++) {
          quantityCustomeList
              .add(result.data?.fullFillYourCravingsCustomProduct?[i].quantity);
          cartItemCustomeIdList.add(
              result.data?.fullFillYourCravingsCustomProduct?[i].cartItemId);
        }

        //////////////////////////////

        showPaginationLoaderInApp(false);
        notifyListeners();
      } else {
        showPaginationLoaderInApp(false);
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      showPaginationLoaderInApp(false);
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
      (Object e) {
        showPaginationLoaderInApp(false);
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e) {
        showPaginationLoaderInApp(false);
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }

  Future<void> getOrderSummary(context, id, cId, route) async {
    offset = 0;
    print(route);
    if (route == 'cartDetail') {
      expectedDateController.clear();
      slotGroupValue = "";
      discountPercentage = "";
      offerGroupValue = "";
      couponCodeController.clear();
    }
    couponCodeController.clear();
    showLoader(true);
    shopId = id.toString();
    cartId = cId.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    orderSummaryRepo
        .viewOrderSummery(
            orderSummeryRequestModel, pref.getString("successToken"))
        .then((response) async {
      log("response.body${response.body}");
      final result = OrderSummaryResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        shopDeliveryTypes = result.orderSummaryData?.shopDeliveryTypes;
        if (route != "orderSummary") {
          customerPickup = result.orderSummaryData?.shopDeliveryTypes
                  ?.shopOwnerCustomerPickup ??
              "";
        }
        shopDetailData = result.orderSummaryData?.shopDetails;
        if (route != "orderSummary") {
          shopDeliverySlots = result.orderSummaryData?.shopDeliverySlots;
        }

        favAllShop = shopDetailData?.shopFavourite == "yes" ? true : false;
        if (route != "orderSummary") {
          expectedDateController.text =
              DateFormat('dd-MM-yyy').format(DateTime.now());
        }
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
        // if (route != "orderSummary") {
        if (groupValue != "") {
          if (result.orderSummaryData?.shopDeliveryTypes
                  ?.shopOwnerCustomerPickup ==
              "active") {
            if (route != "orderSummary") {
              groupValue = "self_pickup";
            }

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
            if (route != "orderSummary") {
              groupValue = "delivery_to";
            }
          }
        }
        // }

        productTotalDiscount =
            orderFinalTotals?.productTotalDiscount.toString() ?? "";
        subTotal = orderFinalTotals?.subTotal.toString() ?? "";

        totalDiscount = orderFinalTotals?.totalDiscount.toString() ?? "";
        customerAddress = result.orderSummaryData?.customerAddresses;
        int addressListLength = customerAddress?.length ?? 0;
        if (route != "orderSummary") {
          for (int i = 0; i < addressListLength; i++) {
            if (customerAddress?[i].deliveryAddressIsDefault == "yes") {
              addressGroupValue =
                  customerAddress?[i].addressId.toString() ?? "";
            }
          }
        }
        cartItemList = result.orderSummaryData?.cartItemList;
        finalCouponList = result.orderSummaryData?.finalCouponList;
        int couponListLength = finalCouponList?.length ?? 0;
        viewMore = List<bool>.filled(couponListLength, false);
        couponDiscount = orderFinalTotals?.couponDiscount.toString() ?? "";
        showLoader(false);
        int deliverySlotLength = shopDeliverySlots?.length ?? 0;
        isSlotAvailable =
            List<bool>.filled(deliverySlotLength, true, growable: false);
        if (groupValue == "delivery_to" && customerAddress!.isEmpty) {
          final read =
              Provider.of<MainScreenController>(context, listen: false);
          read.onNavigation(
              2,
              AddAddressView(
                shopId: shopDetailData?.id.toString(),
                cartId: cartId,
                route: "orderAddAddress",
                isEditAdress: false,
              ),
              context);
        }
        if (route == "addAddress" || route == "editAddress") {
          print("fsfsdfsfsfsdfdsfdfsdfsdfs");
          groupValue = "delivery_to";
          notifyListeners();
        }
        var currentHour = DateTime.now().hour;
        print("currentHour${currentHour}");
        if (route != "orderSummary") {
          for (int i = 0; i < deliverySlotLength; i++) {
            if (shopDeliverySlots?[i] == "shop_owner_slot_9_to_12") {
              if (currentHour <= 11) {
                slotGroupValue = "shop_owner_slot_9_to_12";
                return;
              } else {
                isSlotAvailable[i] = false;
              }
            }
            if (shopDeliverySlots?[i] == "shop_owner_slot_12_to_3") {
              if (currentHour <= 14) {
                slotGroupValue = "shop_owner_slot_12_to_3";
                return;
              } else {
                isSlotAvailable[i] = false;
              }
            }
            if (shopDeliverySlots?[i] == "shop_owner_slot_3_to_6") {
              if (currentHour <= 17) {
                slotGroupValue = "shop_owner_slot_3_to_6";
                return;
              } else {
                isSlotAvailable[i] = false;
              }
            }
            if (shopDeliverySlots?[i] == "shop_owner_slot_6_to_9") {
              if (currentHour <= 20) {
                slotGroupValue = "shop_owner_slot_6_to_9";
                return;
              } else {
                isSlotAvailable[i] = false;
              }
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

  Future<void> onScrollMaxExtent(context) async {
    showPaginationLoaderInApp(true);
    print("1234567890");
    offset = offset + 1;
    getFullFillYourCravingsList(context);

    print(showPaginationLoader);
    notifyListeners();
  }

  void onViewMoreClicked(index) {
    viewMore[index] = true;
    notifyListeners();
  }

  // void onFulFilCarvingsSelected(index) {
  //   isFulFilProductAdded[index] = true;
  //   notifyListeners();
  // }

  // void onFulFilCarvingsCustomeSelected(index) {
  //   isFulFilProductAddedCustome[index] = true;
  //   notifyListeners();
  // }

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

  Future<void> addToCart(pType, pId, sId, index, context) async {
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
          "orderSummary",
        );
        offerGroupValue = "";
        notifyListeners();

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
        if (result.status == 200) {
          print("hellooo");
          final data = result.applyCouponData;
          couponCodeController.text = data?.couponCode.toString() ?? "";
          deliveryCharges =
              double.parse(data?.deliveryCharges ?? "0").toInt().toString();
          selfPickupDeliveryCharges = "0";
          subTotal =
              double.parse(data?.subTotal ?? "0").toInt().toString() ?? "";
          couponDiscount =
              double.parse(data?.couponDiscount ?? "0").toInt().toString() ??
                  "";
          totalAmount = double.parse(data?.total ?? "0").toInt().toString();
          selfPickupTotalAmount =
              (double.parse(totalAmount) - double.parse(deliveryCharges))
                      .toInt()
                      .toString() ??
                  "";
          totalDiscount =
              double.parse(data?.totalDiscount ?? "0").toInt().toString() ?? "";
          discountPercentage = data?.discountPercentage ?? "";
          showOnPageLoader(false);
          showLoader(false);
          Navigator.pop(context);
          notifyListeners();
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.success);
        } else {
          offerGroupValue = "";
          showOnPageLoader(false);
          showLoader(false);
          Navigator.pop(context);
          couponDiscount = "0";
          removeCoupon(context, false);
          notifyListeners();
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
        }
      } else {
        showOnPageLoader(false);
        showLoader(false);
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      showOnPageLoader(false);
      showLoader(false);
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
      (Object e) {
        showOnPageLoader(false);
        showLoader(false);
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e) {
        showOnPageLoader(false);
        showLoader(false);
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

  Future<void> removeCoupon(context, loading) async {
    if (couponCodeController.text == "") {
      Utils.showPrimarySnackbar(context, "No Coupon Added",
          type: SnackType.error);
      return;
    }
    if (loading) {
      showOnPageLoader(true);
    }

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
        if (loading) {
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.success);
        }
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
      Utils.showPrimarySnackbar(
          context, "Select another date as no slot available",
          type: SnackType.error);
      return;
    }
    if (customerAddress!.isEmpty && groupValue == "delivery_to") {
      Utils.showPrimarySnackbar(context, "Add an address",
          type: SnackType.error);
      return;
    }
    int minAmount = shopDetailData?.minimumOrderAmountForDelivery ?? 0;
    double totalOrderAmount = double.parse(
      groupValue == "self_pickup" ? selfPickupTotalAmount : totalAmount,
    );
    if (minAmount > totalOrderAmount) {
      // LoadingOverlay.of(context).hide();
      Utils.showPrimarySnackbar(context,
          "Minimum Order Amount Should be ${shopDetailData?.minimumOrderAmountForDelivery}",
          type: SnackType.error);
      return;
    }
    showOnPageLoader(true);
    final read = Provider.of<MainScreenController>(context, listen: false);
    read.onNavigation(
        2,
        OrderPaymentView(
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
          finalTotalAmount:
              groupValue == "self_pickup" ? selfPickupTotalAmount : totalAmount,
          finalTotalDiscount: totalDiscount,
          totalItems: orderFinalTotals?.itemCount.toString(),
          couponDiscountAmount: couponDiscount,
        ),
        context);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => OrderPaymentView(
    //             cartId: cartId.toString(),
    //             shopId: shopId.toString(),
    //             couponId: offerGroupValue.toString(),
    //             customerDeliveryAddressId: addressGroupValue,
    //             customerDeliveryDate: expectedDateController.text,
    //             customerDeliverySlot: slotGroupValue,
    //             customerDeliveryType: groupValue,
    //             finalDeliveryCharges: groupValue == "self_pickup"
    //                 ? selfPickupDeliveryCharges
    //                 : deliveryCharges == ""
    //                     ? "0"
    //                     : deliveryCharges,
    //             finalSubTotal: subTotal,
    //             finalTotalAmount: groupValue == "self_pickup"
    //                 ? selfPickupTotalAmount
    //                 : totalAmount,
    //             finalTotalDiscount: totalDiscount,
    //             totalItems: orderFinalTotals?.itemCount.toString(),
    //             couponDiscountAmount: couponDiscount,
    //           )),
    // );
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
      //  int deliverySlotLength=shopDeliverySlots?.length??0;
      // isSlotAvailable=List<bool>.filled(shopDeliverySlots?.length??0,true);
      //   for (int i = 0; i < deliverySlotLength; i++) {
      //     if (shopDeliverySlots?[i] == "shop_owner_slot_9_to_12") {
      //       if (currentHour <= 11) {
      //         slotGroupValue = "shop_owner_slot_9_to_12";
      //         return;
      //       }
      //       else{
      //         isSlotAvailable[i]=false;
      //       }
      //     }
      //     if (shopDeliverySlots?[i] == "shop_owner_slot_12_to_3") {
      //       if (currentHour <= 14) {
      //         slotGroupValue = "shop_owner_slot_12_to_3";
      //         return;
      //       }
      //       else{
      //         isSlotAvailable[i]=false;
      //       }
      //     }
      //     if (shopDeliverySlots?[i] == "shop_owner_slot_3_to_6") {
      //       if (currentHour <= 17) {
      //         slotGroupValue = "shop_owner_slot_3_to_6";
      //         return;
      //       }
      //       else{
      //         isSlotAvailable[i]=false;
      //       }
      //     }
      //     if (shopDeliverySlots?[i] == "shop_owner_slot_6_to_9") {
      //       if (currentHour <= 20) {
      //         slotGroupValue = "shop_owner_slot_6_to_9";
      //         return;
      //       }
      //       else{
      //         isSlotAvailable[i]=false;
      //       }
      //     }
      //   }

      if (timeSlot == "shop_owner_slot_9_to_12") {
        print("hello");
        print(currentHour);
        if (currentHour >= 12) {
          isExpectedDeliverySlotNotAvailable = true;
          Timer(Duration(seconds: 3), () {
            isExpectedDeliverySlotNotAvailable = false;
            notifyListeners();
          });

          deliverySlotErrorMsg = "Select another date as no slot available";
          // Select another date as no slot available
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
          deliverySlotErrorMsg = "Select another date as no slot available";
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
          deliverySlotErrorMsg = "Select another date as no slot available";
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
          deliverySlotErrorMsg = "Select another date as no slot available";
          return;
        }
      }
    }

    slotGroupValue = timeSlot;
    notifyListeners();
  }

  void checkDeliveryDateAndSlot() async {
    var currentDate = DateFormat('dd-MM-yyy').format(DateTime.now());
    isSlotAvailable = List<bool>.filled(shopDeliverySlots?.length ?? 0, true);
    if (expectedDateController.text == currentDate) {
      var currentHour = DateTime.now().hour;
      int deliverySlotLength = shopDeliverySlots?.length ?? 0;
      // isSlotAvailable=List<bool>.filled(shopDeliverySlots?.length??0,true);
      for (int i = 0; i < deliverySlotLength; i++) {
        if (shopDeliverySlots?[i] == "shop_owner_slot_9_to_12") {
          if (currentHour <= 11) {
            slotGroupValue = "shop_owner_slot_9_to_12";
            return;
          } else {
            isSlotAvailable[i] = false;
          }
        }
        if (shopDeliverySlots?[i] == "shop_owner_slot_12_to_3") {
          if (currentHour <= 14) {
            slotGroupValue = "shop_owner_slot_12_to_3";
            return;
          } else {
            isSlotAvailable[i] = false;
          }
        }
        if (shopDeliverySlots?[i] == "shop_owner_slot_3_to_6") {
          if (currentHour <= 17) {
            slotGroupValue = "shop_owner_slot_3_to_6";
            return;
          } else {
            isSlotAvailable[i] = false;
          }
        }
        if (shopDeliverySlots?[i] == "shop_owner_slot_6_to_9") {
          if (currentHour <= 20) {
            slotGroupValue = "shop_owner_slot_6_to_9";
            return;
          } else {
            isSlotAvailable[i] = false;
          }
        }
      }

      // if (timeSlot == "shop_owner_slot_9_to_12") {
      //   print("hello");
      //   print(currentHour);
      //   if (currentHour >= 12) {
      //     isExpectedDeliverySlotNotAvailable = true;
      //     Timer(Duration(seconds: 3), () {
      //       isExpectedDeliverySlotNotAvailable = false;
      //       notifyListeners();
      //     });
      //
      //     deliverySlotErrorMsg = "Select another date as no slot available";
      //     // Select another date as no slot available
      //     return;
      //   }
      // }
      // if (timeSlot == "shop_owner_slot_12_to_3") {
      //   if (currentHour >= 15) {
      //     isExpectedDeliverySlotNotAvailable = true;
      //     Timer(Duration(seconds: 3), () {
      //       isExpectedDeliverySlotNotAvailable = false;
      //       notifyListeners();
      //     });
      //     deliverySlotErrorMsg = "Select another date as no slot available";
      //     return;
      //   }
      // }
      // if (timeSlot == "shop_owner_slot_3_to_6") {
      //   print("hiii");
      //   print(currentHour);
      //   if (currentHour >= 18) {
      //     isExpectedDeliverySlotNotAvailable = true;
      //     Timer(Duration(seconds: 3), () {
      //       isExpectedDeliverySlotNotAvailable = false;
      //       notifyListeners();
      //     });
      //     deliverySlotErrorMsg = "Select another date as no slot available";
      //     return;
      //   }
      // }
      // if (timeSlot == "shop_owner_slot_6_to_9") {
      //   if (currentHour >= 21) {
      //     isExpectedDeliverySlotNotAvailable = true;
      //     Timer(Duration(seconds: 3), () {
      //       isExpectedDeliverySlotNotAvailable = false;
      //       notifyListeners();
      //     });
      //     deliverySlotErrorMsg = "Select another date as no slot available";
      //     return;
      //   }
      // }
    }

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
          "orderSummary",
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

/////////////////////////////Admin/////////////////////////////

  //////////////////////////////////Admin/////////////////

  CartItemQuantityReqModel get cartItemQuantityRequestModel =>
      CartItemQuantityReqModel(
          cartItemId: cartItemId,
          quantityAction: quantityAction,
          productType: productType,
          shopId: shopId);

  quantityBtnPressed(value) {
    isQuanityBtnPressed = value;
    notifyListeners();
  }

  Future<void> subtractAdminItemQuantity(
    context,
    CIId,
    index,
    pType,
    pUnitId,
  ) async {
    quantityBtnPressed(true);
    print("*********");
    print(quantityAdminList);
    print(quantityAdminList[index]);
    print("*********");
    quantityAction = "subtract";
    productType = pType;
    print(cartItemAdminIdList);
    cartItemId = cartItemAdminIdList[index].toString();
    print(cartItemId);
    SharedPreferences pref = await SharedPreferences.getInstance();
    cartItemQuantityRepo
        .cartItemQuantity(
            cartItemQuantityRequestModel, pref.getString("successToken"))
        .then((response) async {
      log("response.body${response.body}");
      final result =
          CartItemQuantityResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if (result.status == 200) {
          await getOrderSummary(context, shopId, cartId, "orderSummery");
          int value = quantityAdminList[index];
          quantityAdminList.removeAt(index);
          print("${value}valueeeeeeeee");
          quantityAdminList.insert(index, value - 1);

          if (quantityAdminList[index] == 0) {
            removeFromCart(
                pType,
                pUnitId,
                shopId,
                // index,
                context);
          }

          quantityBtnPressed(false);
          notifyListeners();
        } else {
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
          quantityBtnPressed(false);
        }
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
        quantityBtnPressed(false);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
      quantityBtnPressed(false);
    }).catchError(
      (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        quantityBtnPressed(false);
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }
////////////////////////////////////////////////////////////

  Future<void> addAdminItemQuantity(context, CIId, pType, index) async {
    quantityBtnPressed(true);
    quantityAction = "add";
    cartItemId = cartItemAdminIdList[index].toString();
    productType = pType;
    SharedPreferences pref = await SharedPreferences.getInstance();
    cartItemQuantityRepo
        .cartItemQuantity(
            cartItemQuantityRequestModel, pref.getString("successToken"))
        .then((response) async {
      print("hello");
      log("response.body${response.body}");
      final result =
          CartItemQuantityResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if (result.status == 200) {
          print("44444");
          print(cartId);
          print("44444");
          await getOrderSummary(context, shopId, cartId, "orderSummery");
          int value = quantityAdminList[index];
          quantityAdminList.removeAt(index);
          quantityAdminList.insert(index, value + 1);
          quantityBtnPressed(false);

          notifyListeners();
        } else {
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
          quantityBtnPressed(false);
        }
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
        quantityBtnPressed(false);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
      quantityBtnPressed(false);
    }).catchError(
      (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        quantityBtnPressed(false);
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }

////////////////////////////////////////////////CUSTOME FUNCTIION////////////////////////////
  Future<void> subtractCustomeItemQuantity(
      context, CIId, index, pType, pUnitId) async {
    quantityBtnPressed(true);
    print("*********");
    print(quantityCustomeList);
    print(quantityCustomeList[index]);
    print("*********");
    quantityAction = "subtract";
    productType = pType;
    print(cartItemCustomeIdList);
    cartItemId = cartItemCustomeIdList[index].toString();
    print(cartItemId);
    SharedPreferences pref = await SharedPreferences.getInstance();
    cartItemQuantityRepo
        .cartItemQuantity(
            cartItemQuantityRequestModel, pref.getString("successToken"))
        .then((response) async {
      log("response.body${response.body}");
      final result =
          CartItemQuantityResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if (result.status == 200) {
          await getOrderSummary(context, shopId, cartId, "orderSummery");
          int value = quantityCustomeList[index];
          quantityCustomeList.removeAt(index);
          print("${value}valueeeeeeeee");
          quantityCustomeList.insert(index, value - 1);

          if (quantityCustomeList[index] == 0) {
            removeFromCart(
                pType,
                pUnitId,
                shopId,
                // index,
                context);
          }
          quantityBtnPressed(false);
          notifyListeners();
        } else {
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
          quantityBtnPressed(false);
        }
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
        quantityBtnPressed(false);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
      quantityBtnPressed(false);
    }).catchError(
      (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        quantityBtnPressed(false);
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }

////////////////////////////////////////////////
  Future<void> addCustomeItemQuantity(context, CIId, pType, index) async {
    quantityBtnPressed(true);
    quantityAction = "add";
    cartItemId = cartItemCustomeIdList[index].toString();
    productType = pType;
    SharedPreferences pref = await SharedPreferences.getInstance();
    cartItemQuantityRepo
        .cartItemQuantity(
            cartItemQuantityRequestModel, pref.getString("successToken"))
        .then((response) async {
      print("hello");
      log("response.body${response.body}");
      final result =
          CartItemQuantityResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if (result.status == 200) {
          print("44444");
          print(cartId);
          print("44444");
          await getOrderSummary(context, shopId, cartId, "orderSummery");
          int value = quantityCustomeList[index];
          quantityCustomeList.removeAt(index);
          quantityCustomeList.insert(index, value + 1);
          quantityBtnPressed(false);

          notifyListeners();
        } else {
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
          quantityBtnPressed(false);
        }
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
        quantityBtnPressed(false);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
      quantityBtnPressed(false);
    }).catchError(
      (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        quantityBtnPressed(false);
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }
}
