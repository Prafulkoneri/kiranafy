import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/order_payment/model/c_place_order_model.dart';
import 'package:local_supper_market/screen/customer/order_payment/model/order_payment_model.dart';
import 'package:local_supper_market/screen/customer/order_payment/repository/c_place_order_repo.dart';
import 'package:local_supper_market/screen/customer/order_payment/repository/order_payment_repo.dart';
import 'package:local_supper_market/screen/customer/order_payment/view/check_status_and_home_view.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderPaymentController extends ChangeNotifier {
  OrderPaymentViewRepo orderPaymentRepo = OrderPaymentViewRepo();
  PlaceOrderRepo placeOrderRepo = PlaceOrderRepo();

  TextEditingController transactionIdController = TextEditingController();
  bool isLoading = true;
  bool isStackLoading = false;
  String? shopId = "";
  String? cartId = "";
  String? couponId = "";
  String? customerDeliveryAddressId = "";
  String? customerDeliveryDate = "";
  String? customerDeliverySlot = "";
  String? customerDeliveryType = "";
  String? finalTotalAmount = "";
  String? finalTotalDiscount = "";
  String? totalItems = "";
  String? groupValue = "";
  String? finalSubTotal = "";
  String? finalDeliveryCharges = "";
  String? customerPaymentMode = "";

  ShopDetails? shopDetailData;
  OrderPaymentData? orderPaymentData;
  Future<void> initState(context, cId, id, cuId, cdaId, cdDate, cdSlot, cdType,
      ftAmount, ftDiscount, tItems, fSubTotal, fDCharges) async {
    groupValue = "";
    await orderPayment(context, cId, id, cuId, cdaId, cdDate, cdSlot, cdType,
        ftAmount, ftDiscount, tItems, fSubTotal, fDCharges);
  }

  void onRadioButtonSelected(value) {
    groupValue = value;
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

  OrderPaymentReqModel get orderPaymentReqModel => OrderPaymentReqModel(
      shopId: shopId.toString(),
      cartId: cartId.toString(),
      couponId: couponId.toString(),
      customerDeliveryAddressId: customerDeliveryAddressId.toString(),
      customerDeliveryDate: customerDeliveryDate.toString(),
      customerDeliverySlot: customerDeliverySlot.toString(),
      customerDeliveryType: customerDeliveryType.toString(),
      finalTotalAmount: finalTotalAmount.toString(),
      finalTotalDiscount: finalTotalDiscount.toString(),
      totalItems: totalItems.toString(),
      finalSubTotal: finalSubTotal.toString(),
      finalDeliveryCharges: finalDeliveryCharges.toString());

  Future<void> orderPayment(context, cId, id, cuId, cdaId, cdDate, cdSlot,
      cdType, ftAmount, ftDiscount, tItems, fSubTotal, fDCharges) async {
    showLoader(true);
    shopId = id.toString();
    cartId = cId.toString();
    couponId = cuId.toString();
    customerDeliveryAddressId = cdaId.toString();
    customerDeliveryDate = cdDate.toString();
    customerDeliverySlot = cdSlot.toString();
    customerDeliveryType = cdType.toString();
    finalTotalAmount = ftAmount.toString();
    finalTotalDiscount = ftDiscount.toString();
    totalItems = tItems.toString();
    finalSubTotal = fSubTotal.toString();
    finalDeliveryCharges = fDCharges.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    orderPaymentRepo
        .orderPayment(orderPaymentReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = OrderPaymentResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        orderPaymentData = result.orderPayment;

        shopDetailData = result.orderPayment?.shopDetails;
        showLoader(false);
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

  /////////////////////////////////////////////////////////////////////////////////////
  CustomerPlaceOrderReqModel get customerPlaceOrderReqModel =>
      CustomerPlaceOrderReqModel(
          shopId: shopId.toString(),
          cartId: cartId.toString(),
          couponId: couponId.toString(),
          customerDeliveryAddressId: customerDeliveryAddressId.toString(),
          customerDeliveryDate: customerDeliveryDate.toString(),
          customerDeliverySlot: customerDeliverySlot.toString(),
          customerDeliveryType: customerDeliveryType.toString(),
          finalTotalAmount: finalTotalAmount.toString(),
          finalTotalDiscount: finalTotalDiscount.toString(),
          totalItems: totalItems.toString(),
          finalSubTotal: finalSubTotal.toString(),
          finalDeliveryCharges: finalDeliveryCharges.toString(),
          customerPaymentMode: groupValue);
  Future<void> placeOrder(
    context,
  ) async {
    showStackLoader(true);
    if (groupValue == "") {
      Utils.showPrimarySnackbar(context, "please select Payment Mode",
          type: SnackType.error);
      return;
    }
    if (groupValue == "upi" || groupValue == "qr_code") {
      if (transactionIdController.text.isEmpty) {
        Utils.showPrimarySnackbar(context, "Enter Payment Transaction Id",
            type: SnackType.error);
        return;
      }
    }
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    placeOrderRepo
        .placeOrder(customerPlaceOrderReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result =
          CustomerPlaceOrderResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MainScreenView(index: 2, screenName: CheckOrderStatusView())),
          (Route<dynamic> route) => false,
        );
        showStackLoader(false);
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

  copyCodeForCoupanList(context, offerMsg) {
    Clipboard.setData(ClipboardData(text: offerMsg)).then((_) {
      Utils.showPrimarySnackbar(context, "Upi ID copy",
          type: SnackType.success);
    });
  }



  Future<void> removeCoupon()async{}
}