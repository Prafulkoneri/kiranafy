import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/cart/model/add_product_to_cart_model.dart';
import 'package:local_supper_market/screen/customer/cart/repository/add_product_to_cart_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/add_fav_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/remove_fav_shop_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/add_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/remove_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/order_summery/model/order_summery_model.dart';
import 'package:local_supper_market/screen/customer/order_summery/repository/order_summery_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderSummeryController extends ChangeNotifier {
  OrderSummeryRepo orderSummeryRepo = OrderSummeryRepo();
  RemoveFavShopRepo removeFavShopRepo = RemoveFavShopRepo();
  AddFavShopRepo addFavShopRepo = AddFavShopRepo();
  AddProductToCartRepo addProductToCartRepo = AddProductToCartRepo();
  RemoveFavReqModel get removeFavReqModel => RemoveFavReqModel(
        shopId: shopId.toString(),
      );
  String shopId = "";
  String cartId = "";
  String groupValue = "deliveryTo";
  ShopDetails? shopDetailData;
  ShopDeliveryTypes? shopDeliveryTypes;
  ShopDeliverySlots? shopDeliverySlots;
  OrderFinalTotals? orderFinalTotals;
  List<CustomerAddress>? customerAddress;
  List<CartItemList>? cartItemList;
  List<FinalCouponList>? finalCouponList;
  List<FullFillYourCraving>? fullFillYourCravings;
  bool isLoading = true;
  bool favAllShop = true;
  List<bool> defaultSelectedAddress = [];

  Future<void> initState(context, cId, id) async {
    groupValue = "deliveryTo";
    await orderSummery(context, cId, id);
  }

  void showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  void onRadioButtonSelected(value) {
    groupValue = value;
    notifyListeners();
  }

  OrderSummeryReqModel get orderSummeryRequestModel =>
      OrderSummeryReqModel(shopId: shopId, cartId: cartId);

  Future<void> orderSummery(
    context,
    id,
    cId,
  ) async {
    shopId = id.toString();
    cartId = cId.toString();
    showLoader(true);

    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    orderSummeryRepo
        .viewOrderSummery(
            orderSummeryRequestModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = OrderSummeryResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        // shopDeliveryTypes=result.orderSummeryData?.shopDeliveryTypes ??"Delivery To";
        if (result
                .orderSummeryData?.shopDeliveryTypes?.shopOwnerCustomerPickup ==
            "active") {
          groupValue = "selfPickup";
        } else {
          groupValue = "deliveryTo";
        }
        // groupValue = data?.deliveryAddressType ?? "home";
        shopDetailData = result.orderSummeryData?.shopDetails;
        // shopDeliveryTypes = result.orderSummeryData?.shopDeliveryTypes;
        shopDeliverySlots = result.orderSummeryData?.shopDeliverySlots;
        orderFinalTotals = result.orderSummeryData?.orderFinalTotals;
        customerAddress = result.orderSummeryData?.customerAddresses;
        cartItemList = result.orderSummeryData?.cartItemList;
        finalCouponList = result.orderSummeryData?.finalCouponList;
        fullFillYourCravings = result.orderSummeryData?.fullFillYourCravings;

        print("bye");

        print("uivynuibnywetinyiqwn8wq7eyvnb8q8ew");
        showLoader(false);

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
}
