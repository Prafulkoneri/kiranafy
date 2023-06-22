import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/model/order_status_mode.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/model/shop_owner_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/repository/order_status_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/repository/shop_owner_order_repo.dart';

import 'package:local_supper_market/screen/shop_owner/s_products/model/shop_add_product_list_model.dart';

import 'package:local_supper_market/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopOwnerOrderViewController extends ChangeNotifier {
  String? orderId = "";
  String? orderStatus = "";
  String? orderCancelledReason = "";
  String? orderCancelledReasonId = "";
  bool isLoading = true;
  bool isStackLoading = false;
  ShopOrderViewData? shopOrderViewData;
  OrderDetails? orderDetails;
  CouponDetails? couponDetails;
  DeliveryAddressDetails? deliveryAddressDetails;
  List<OrderProductDetail>? orderProductDetails;
  ShopOrderViewRepo shopOrderViewRepo = ShopOrderViewRepo();

  ShopOrderViewRequestModel get shopOrderViewReqModel =>
      ShopOrderViewRequestModel(orderId: orderId.toString());
  //////////////
  ShopOwnerOrderStatusChangedRepo orderStatusChangedRepo =
      ShopOwnerOrderStatusChangedRepo();
  OrderStatusChangeRequestModel get orderStatusChangedRequestModel =>
      OrderStatusChangeRequestModel(
          orderId: orderId.toString(),
          orderStatus: orderStatus.toString(),
          orderCancelledReason: orderCancelledReason.toString(),
          orderCancelledReasonId: orderCancelledReasonId.toString());
  Future<void> initState(
    context,
    orId,
  ) async {
    await shopOwnerOrderView(context, orId);
    // shopOrderStatus(context, orId, oStatus, oCReason, oCReasonId);
    notifyListeners();
  }

  void showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  void showStackLoader(value) {
    isStackLoading = value;
    notifyListeners();
  }

  Future<void> shopOwnerOrderView(context, orId) async {
    orderId = orId.toString();
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();

    shopOrderViewRepo
        .shopOrderView(shopOrderViewReqModel, pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result = ShopOrderViewResModel.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        shopOrderViewData = result.shopOrderViewData;
        orderDetails = shopOrderViewData?.orderDetails;
        couponDetails = shopOrderViewData?.couponDetails;
        deliveryAddressDetails = shopOrderViewData?.deliveryAddressDetails;
        orderProductDetails = shopOrderViewData?.orderProductDetails;
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

  Future<void> shopOrderStatus(
      context, orId, oStatus, oCReason, oCReasonId) async {
    orderId = orId.toString();
    orderStatus = oStatus.toString();
    orderCancelledReason = oCReason.toString();
    orderCancelledReasonId = oCReasonId.toString();

    isLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();

    orderStatusChangedRepo
        .orderStatus(
            orderStatusChangedRequestModel, pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result =
          OrderStatusChangeResModel.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        shopOwnerOrderView(context, orId);
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
