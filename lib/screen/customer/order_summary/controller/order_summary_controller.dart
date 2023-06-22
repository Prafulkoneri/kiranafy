import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
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
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderSummaryController extends ChangeNotifier {
  OrderSummaryRepo orderSummaryRepo = OrderSummaryRepo();
  RemoveFavShopRepo removeFavShopRepo = RemoveFavShopRepo();
  AddFavShopRepo addFavShopRepo = AddFavShopRepo();
  AddProductToCartRepo addProductToCartRepo = AddProductToCartRepo();
  ApplyCouponRepo applyCouponRepo = ApplyCouponRepo();
  RemoveCouponRepo removeCouponRepo = RemoveCouponRepo();

  RemoveFavReqModel get removeFavReqModel => RemoveFavReqModel(
        shopId: shopId.toString(),
      );
  TextEditingController expectedDateController = TextEditingController();
  String shopId = "";
  String cartId = "";
  String groupValue = "";
  String discountPercentage = "";
  List<bool> viewMore=[];
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
  String couponDiscount = "";
  String deliveryCharges = "";
  String productTotalDiscount = "";
  String subTotal = "";
  String total = "";
  String totalDiscount = "";
  String customerPickup = "";
  TextEditingController couponCodeController = TextEditingController();

  Future<void> initState(context, cId, id, refresh, route) async {
    // if(route=="addAddress"||route=="editAddress"){
    //    groupValue="delivery_to";
    // }
    print("fsfsdfsdfsdf");
    print(route);
    if (customerPickup == "active" && route == "addAddress") {
      groupValue = "self_pickup";
    } else {
      groupValue = "delivery_to";
    }
    if (refresh) {
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
    notifyListeners();
  }

  void onDeliverySlotSelected(value) {
    slotGroupValue = value;
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
      offerGroupValue="";
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
        customerPickup = result.orderSummaryData?.shopDeliveryTypes?.shopOwnerCustomerPickup ?? "";
        if (result.orderSummaryData?.shopDeliveryTypes?.shopOwnerCustomerPickup == "active") {
          groupValue = "self_pickup";
        } else {
          groupValue = "delivery_to";
        }


        shopDetailData = result.orderSummaryData?.shopDetails;
        shopDeliverySlots = result.orderSummaryData?.shopDeliverySlots;
        orderFinalTotals = result.orderSummaryData?.orderFinalTotals;
        deliveryCharges = orderFinalTotals?.deliveryCharges ?? "";
        productTotalDiscount = orderFinalTotals?.productTotalDiscount.toString() ?? "";
        subTotal = orderFinalTotals?.subTotal.toString() ?? "";
        total = orderFinalTotals?.total.toString() ?? "";
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
        int couponListLength=finalCouponList?.length??0;
          viewMore=List<bool>.filled(couponListLength,false);
        couponDiscount=orderFinalTotals?.couponDiscount.toString()??"";
        fullFillYourCravings = result.orderSummaryData?.fullFillYourCravings;
        showLoader(false);
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

  void onViewMoreClicked(index){
    viewMore[index]=true;
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

  AddFavReqModel get addFavReqModel => AddFavReqModel(
        shopId: shopId.toString(),
      );

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
        total: orderFinalTotals?.total.toString(),
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
        deliveryCharges = data?.deliveryCharges.toString() ?? "";
        subTotal = data?.subTotal ?? "";
        couponDiscount=data?.couponDiscount.toString()??"";
        total = data?.total ?? "";
        totalDiscount = data?.totalDiscount ?? "";
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

  CustomerRemoveCouponsRequestModel get customerRemoveCouponsRequestModel=>CustomerRemoveCouponsRequestModel(
    cartId: cartId,
    shopId: shopId,
  );

  Future<void> removeCoupon(context)async{
    if(couponCodeController.text==""){
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
        offerGroupValue="";
        deliveryCharges = data?.removeCouponData?.deliveryCharges.toString() ?? "";
        subTotal = data?.removeCouponData?.subTotal.toString() ?? "";
        total = data?.removeCouponData?.total.toString()?? "";
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
      Utils.showPrimarySnackbar(context, "Select expected date",
          type: SnackType.error);
      return;
    }
    if (slotGroupValue == "") {
      Utils.showPrimarySnackbar(context, "Select a slot",
          type: SnackType.error);
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
                finalDeliveryCharges: deliveryCharges==""?"0":deliveryCharges,
                finalSubTotal: subTotal,
                finalTotalAmount: total,
                finalTotalDiscount: totalDiscount,
                totalItems: orderFinalTotals?.itemCount.toString(),
              )),
    );
    showOnPageLoader(false);
  }
}
