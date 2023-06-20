import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/order_payment/model/order_payment_model.dart';
import 'package:local_supper_market/screen/customer/order_payment/repository/order_payment_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderPaymentController extends ChangeNotifier {
  OrderPaymentViewRepo orderPaymentRepo = OrderPaymentViewRepo();

  TextEditingController transactionIdController = TextEditingController();
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
