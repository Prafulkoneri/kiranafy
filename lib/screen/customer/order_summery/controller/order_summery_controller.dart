import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/order_summery/model/order_summery_model.dart';
import 'package:local_supper_market/screen/customer/order_summery/repository/order_summery_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderSummeryController extends ChangeNotifier {
  OrderSummeryRepo orderSummeryRepo = OrderSummeryRepo();
  String shopId = "";
  String cartId = "";
  ShopDetails? shopDetailData;
  ShopDeliveryTypes? shopDeliveryTypes;
  ShopDeliverySlots? shopDeliverySlots;
  OrderFinalTotals? orderFinalTotals;
  List<CustomerAddress>? customerAddress;
  List<CartItemList>? cartItemList;
  List<FinalCouponList>? finalCouponList;
  List<FullFillYourCraving>? fullFillYourCravings;
  bool isLoading = true;

  Future<void> initState(context, cId, id) async {
    await orderSummery(context, cId, id);
  }

  void showLoader(value) {
    isLoading = value;
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
        shopDetailData = result.orderSummeryData?.shopDetails;
        shopDeliveryTypes = result.orderSummeryData?.shopDeliveryTypes;
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
}
