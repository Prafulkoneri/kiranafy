import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_status/view/s_order_status_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/model/cancel_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/model/order_status_mode.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/model/remove_product_from_order.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/model/shop_owner_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/repository/add_remove_product_from_order_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/repository/cancel_reason_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/repository/order_status_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/repository/shop_owner_order_repo.dart';

import 'package:local_supper_market/screen/shop_owner/s_products/model/shop_add_product_list_model.dart';

import 'package:local_supper_market/utils/Utils.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopOwnerOrderViewController extends ChangeNotifier {
  String orderId = "";
  String deliveryCode = "";
  String orderStatus = "";
  String orderCancelledReason = "";
  String orderCancelledReasonId = "";
  String deliveryCodeError = "";
  String subTotal="0";
  String totalDiscount="0";
  String deliveryCharges="0";
  String totalAmount="0";

  // String? deliveryCode = "";
  TextEditingController reasonController = TextEditingController();
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
  AddRemoveProductFromOrderRepo addRemoveProductFromOrderRepo =
      AddRemoveProductFromOrderRepo();
  List<CancelReasonList>? cancelReasondata;
  String cancelOrderErrorMsg = "";
  bool isCancelOrderErrorMsgVisible = false;
  String cancellationId = "";
  String productId = "";
  List<bool> selectedProductList = [];


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
    orderId = "";
    orderStatus = "";
    orderCancelledReason = "";
    orderCancelledReasonId = "";
    deliveryCode = "";
    reasonController.clear();
    await shopOwnerOrderView(context, orId, true);

    getCancelOrderList(context);
    notifyListeners();
  }

  void showLoader(value) {
    isLoading = value;
    print("loading........${isLoading}");
    notifyListeners();
  }



  Future<void> shopOwnerOrderView(context, orId, showLoading) async {
    if (showLoading) {
      showLoader(true);
    }
    selectedProductList.clear();
    orderId = orId.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    shopOrderViewRepo
        .shopOrderView(shopOrderViewReqModel, pref.getString("successToken"))
        .then((response) async {
      log(response.body);
      final result = ShopOrderViewResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        shopOrderViewData = result.shopOrderViewData;
        orderDetails = shopOrderViewData?.orderDetails;
        couponDetails = shopOrderViewData?.couponDetails;
        deliveryAddressDetails = shopOrderViewData?.deliveryAddressDetails;
        orderProductDetails = shopOrderViewData?.orderProductDetails;
        subTotal=orderDetails?.subTotal??"";
        totalAmount=orderDetails?.totalAmount??"";
        deliveryCharges=orderDetails?.deliveryCharges??"";
        totalDiscount=orderDetails?.totalDiscount??"";
        selectedProductList = List<bool>.filled(
            orderProductDetails?.length ?? 0, false,
            growable: true);
        int productListLength = orderProductDetails?.length ?? 0;
        for (int i = 0; i < productListLength; i++) {
          if (orderProductDetails?[i].status == "active") {
            selectedProductList.removeAt(i);
            selectedProductList.insert(i, true);
          }
          else {
            selectedProductList.removeAt(i);
            selectedProductList.insert(i, false);
          }

        }
        await getCancelOrderList(context);
        if (showLoading) {
          showLoader(false);
        }
        else{
          showLoader(true);
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

  Future<void> shopOrderStatus(
      context, orId, oStatus, oCReason, oCReasonId, dCode) async {
    orderId = orId.toString();
    orderStatus = oStatus.toString();
    orderCancelledReason = oCReason.toString();
    orderCancelledReasonId = oCReasonId.toString();
    deliveryCode = dCode.toString();

    if(oStatus=="order_confirmed"){
      List checkDataList=[];
      for(int i=0;i<selectedProductList.length;i++){
        if(selectedProductList[i]==true){
          checkDataList.add(selectedProductList[i]);
        }
        if(checkDataList.isEmpty){
          Utils.showPrimarySnackbar(context, "No product selected",
              type: SnackType.error);
          return;
        }
      }

    }

    if (oStatus == "order_cancelled") {
      if (!isOtherReasonSelected && orderCancelledReasonId == "") {
        cancelOrderErrorMsg = "Please Enter reason for cancellation";
        isCancelOrderErrorMsgVisible = true;
        notifyListeners();
        Timer(Duration(seconds: 3), () {
          isCancelOrderErrorMsgVisible = false;
          notifyListeners();
        });
        return;
      }
      if (orderCancelledReason == "") {
        cancelOrderErrorMsg = "Please Enter reason for cancellation";
        isCancelOrderErrorMsgVisible = true;
        notifyListeners();
        Timer(Duration(seconds: 3), () {
          isCancelOrderErrorMsgVisible = false;
          notifyListeners();
        });
        return;
      }
    }

    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    orderStatusChangedRepo
        .orderStatus(
            orderStatusChangedRequestModel, pref.getString("successToken"))
        .then((response) async {

      final result =
          OrderStatusChangeResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if (oStatus == "order_cancelled") {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SMainScreenView(index: 1, screenName: SOrderStatusView())),
            (Route<dynamic> route) => false,
          );
        }
        if (result.message != "Delivery code not matched. Please try again.") {
          print("dafaadadasd");
          await shopOwnerOrderView(context, orId, true);
          isDeliveryCodeError = false;
          if (oStatus == "order_delivered") {
            Navigator.pop(context);
          }
          if (oStatus == "order_cancelled") {
            Navigator.pop(context);
          }
        } else {
          showLoader(false);
          deliveryCodeError = result.message ?? "";
          isDeliveryCodeError = true;
          notifyListeners();
          Timer(Duration(seconds: 3), () {
            isDeliveryCodeError = false;
            notifyListeners();
          });
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
    SharedPreferences pref = await SharedPreferences.getInstance();
    orderCancelReasonRepo.OrderCancelReason(pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result = CancelModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        cancelReasondata = result.cancelReasondata;
        int cancelOrderLength = cancelReasondata?.length ?? 0;
        isSelectedReason = List<bool>.filled(cancelOrderLength, false);
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

  void onSelectReason(index, value, id) {
    if (isSelectedReason[index]) {
      isSelectedReason[index] = false;
      cancellationId = "";
      notifyListeners();
      return;
    }
    int cancelOrderLength = cancelReasondata?.length ?? 0;

    isSelectedReason =
        List<bool>.filled(cancelOrderLength, false, growable: true);
    isSelectedReason[index] = true;
    cancellationId = id.toString();
    isOtherReasonSelected = false;

    // isSelectedReason[index]=true;

    notifyListeners();
  }

  void onOtherSelected(value) {
    if (isOtherReasonSelected) {
      isOtherReasonSelected = false;
      notifyListeners();
      return;
    }
    int cancelOrderLength = cancelReasondata?.length ?? 0;
    isSelectedReason =
        List<bool>.filled(cancelOrderLength, false, growable: true);
    isOtherReasonSelected = true;
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

  AddRemoveProductFromOrderReqModel get addRemoveProductFromOrderReqModel =>
      AddRemoveProductFromOrderReqModel(
        orderProductId: productId,
      );

  Future<void> selectProducts(context,index,id,value) async {

   LoadingOverlay.of(context).show();

    productId=id.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    addRemoveProductFromOrderRepo
        .addremoveProductFromOrder(
            addRemoveProductFromOrderReqModel, pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result =
          AddRemoveProductFromOrderResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if(selectedProductList[index]){
          selectedProductList.removeAt(index);
          selectedProductList.insert(index,false);
        }
        else{
          selectedProductList.removeAt(index);
          selectedProductList.insert(index,true);
        }

        totalDiscount=result.data?.totalDiscount.toString()??"";
        totalAmount=result.data?.totalAmount.toString()??"";
        subTotal=result.data?.subTotalAmount.toString()??"";
        deliveryCharges=result.data?.deliveryCharges.toString()??"";
        LoadingOverlay.of(context).hide();
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

///////////////////////////////
}
