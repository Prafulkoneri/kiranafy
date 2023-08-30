import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/payment_refund/model/payment_refund_list_model.dart';
import 'package:local_supper_market/screen/shop_owner/payment_refund/repository/payment_refund_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_payments/model/payment_history_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_payments/repositotry/payment_history_repo.dart';

import 'package:local_supper_market/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentRefundListController extends ChangeNotifier {
  //  toDateController = TextEditingController();
  String date = "";
  bool isLoading = true;
  bool isStackLoading = false;
  bool isPendingList = true;
  bool isCompletedList = false;
  PaymentRefundData? paymentrefunddata;
  List<OrdersRefundListElement>? ordersRefundList;
  List<OrdersRefundListElement>? pendingOrdersList;
  List<ConfirmedOrdersList>? confirmedOrdersList;
  int? currentMonthCollection;
  int? totalBusiness;
  Future<void> initState(
    context,
  ) async {
    await refundPaymentList(context, "");
    notifyListeners();
  }

  void onPendingList() {
    isPendingList = true;
    isCompletedList = false;
    notifyListeners();
  }

  void onCompletedList() {
    isCompletedList = true;
    isPendingList = false;
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

  void onClear(context, dates) {
    date = "";
    refundPaymentList(
      context,
      dates,
    );
    notifyListeners();
  }

  void onNavigationFromDashboard(value) {
    if (value == "completed") {
      isCompletedList = true;
      isPendingList = false;
    } else {
      isCompletedList = false;
      isPendingList = true;
    }
    notifyListeners();
  }

  PaymentRefundListRepo paymentRefundListRepo = PaymentRefundListRepo();
  ShopPaymentRefundListRequestModel get paymentHistoaryRequestModel =>
      ShopPaymentRefundListRequestModel(date: date);
  Future<void> refundPaymentList(context, dates) async {
    // print(dates);
    date = dates;
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    paymentRefundListRepo
        .paymentRefund(
            paymentHistoaryRequestModel, pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result = ShopPaymentRefundListResponseModel.fromJson(
          jsonDecode(response.body));

      if (response.statusCode == 200) {
        paymentrefunddata = result.paymentrefunddata;
        pendingOrdersList = paymentrefunddata?.pendingOrdersList;
        confirmedOrdersList = paymentrefunddata?.confirmedOrdersList;

        // currentMonthCollection =
        //     result.paymentrefunddata?.currentMonthCollection ?? 0;
        // totalBusiness = result.paymentrefunddata?.totalBusiness ?? 0;
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

  void onToDateSelected(context, dates) {
    refundPaymentList(context, dates);
    date = dates;
    notifyListeners();
  }
}
