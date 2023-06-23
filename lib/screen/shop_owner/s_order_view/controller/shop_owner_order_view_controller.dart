import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/model/cancel_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/model/order_status_mode.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/model/shop_owner_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/repository/cancel_reason_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/repository/order_status_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/repository/shop_owner_order_repo.dart';

import 'package:local_supper_market/screen/shop_owner/s_products/model/shop_add_product_list_model.dart';

import 'package:local_supper_market/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopOwnerOrderViewController extends ChangeNotifier {
  String orderId = "";
  String deliveryCode = "";
  String orderStatus = "";
  String orderCancelledReason = "";
  String orderCancelledReasonId = "";
  String deliveryCodeError = "";
  // String? deliveryCode = "";

  bool isDeliveryCodeError = false;
  bool isLoading = true;
  bool isStackLoading = false;
  List<bool> isSelectedReason = [];
  bool isOtherReasonSelected = false;
  ShopOrderViewData? shopOrderViewData;
  OrderDetails? orderDetails;
  CouponDetails? couponDetails;
  DeliveryAddressDetails? deliveryAddressDetails;
  List<OrderProductDetail>? orderProductDetails;
  ShopOrderViewRepo shopOrderViewRepo = ShopOrderViewRepo();
  OrderCancelReasonRepo orderCancelReasonRepo = OrderCancelReasonRepo();
  List<CancelReasonList>? cancelReasondata;
  String cancelOrderErrorMsg="";
  bool isCancelOrderErrorMsgVisible=false;

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
          orderCancelledReasonId: orderCancelledReasonId.toString(),
          deliveryCode: deliveryCode.toString());
  Future<void> initState(
    context,
    orId,
  ) async {
    await shopOwnerOrderView(context, orId);

    getCancelOrderList(context);
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
      log(response.body);
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
      context, orId, oStatus, oCReason, oCReasonId, dCode) async {
    orderId = orId.toString();
    orderStatus = oStatus.toString();
    orderCancelledReason = oCReason.toString();
    orderCancelledReasonId = oCReasonId.toString();
    deliveryCode = dCode.toString();

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
        if (result.status == 200) {
          shopOwnerOrderView(context, orId);
          isDeliveryCodeError = false;
        } else {
          deliveryCodeError = result.message ?? "";
          isDeliveryCodeError = true;
          notifyListeners();
          Timer(Duration(seconds: 3), () {
            print("duration");
            isDeliveryCodeError = false;
            notifyListeners();
          });

          showLoader(false);
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

  Future<void> getCancelOrderList(context) async {
    showLoader(true);
    print("loading");
    SharedPreferences pref = await SharedPreferences.getInstance();
    orderCancelReasonRepo.OrderCancelReason(pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result = CancelModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        cancelReasondata = result.cancelReasondata;
        int cancelOrderLength=cancelReasondata?.length??0;
          isSelectedReason=List<bool>.filled(cancelOrderLength,false);
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

  // void onSelectReason(value) {
  //   if (!isSelectedReason) {
  //     isSelectedReason = true;

  //   } else {
  //     isSelectedReason = false;
  //   }
  //   notifyListeners();
  // }

  void onSelectReason(index,value) {
    if(isSelectedReason[index]){
      isSelectedReason[index]=false;
      notifyListeners();
      return;
    }
    int cancelOrderLength=cancelReasondata?.length??0;

    isSelectedReason=List<bool>.filled(cancelOrderLength,false,growable:true);
      isSelectedReason[index]=true;
    isOtherReasonSelected=false;

    // isSelectedReason[index]=true;

    notifyListeners();
  }

  void onOtherSelected(value){
    if(isOtherReasonSelected){
      isOtherReasonSelected=false;
      notifyListeners();
      return;
    }
    int cancelOrderLength=cancelReasondata?.length??0;
    isSelectedReason=List<bool>.filled(cancelOrderLength,false,growable:true);
    isOtherReasonSelected=true;
    notifyListeners();
  }

  void onCancelErrorMissageDismiss() {
    isCancelOrderErrorMsgVisible = false;
    notifyListeners();
  }



  Future<void> onDeliveryCode(code) async {
    deliveryCode = code;
    notifyListeners();
  }

  void onCodeDismiss() {
    isDeliveryCodeError = false;
    notifyListeners();
  }
  ///////////////////////////////
}
