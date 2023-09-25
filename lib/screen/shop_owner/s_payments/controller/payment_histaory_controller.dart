import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_payments/model/payment_history_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_payments/repositotry/payment_history_repo.dart';

import 'package:local_supper_market/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentHistoryController extends ChangeNotifier {
  //  toDateController = TextEditingController();
  String date = "";
  bool isLoading = true;
  bool isStackLoading = false;
  PaymentHistoryData? paymentdata;
  List<OrdersList>? ordersList;
  int? currentMonthCollection;
  int? totalBusiness;
  Future<void> initState(
    context,
  ) async {
    await paymentHistory(context, "");

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

  PaymentHistoryRepo paymentHistoryRepo = PaymentHistoryRepo();
  PaymentHistoaryRequestModel get paymentHistoryRequestModel =>
      PaymentHistoaryRequestModel(date: date);
  Future<void> paymentHistory(context, dates) async {
    // print(dates);
    date = dates;
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    paymentHistoryRepo
        .paymentHistory(
            paymentHistoryRequestModel, pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result =
          PaymentHistoaryResModel.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        paymentdata = result.paymentdata;
        ordersList = paymentdata?.ordersList;

        currentMonthCollection =
            result.paymentdata?.currentMonthCollection ?? 0;
        totalBusiness = result.paymentdata?.totalBusiness ?? 0;
        showLoader(false);
        notifyListeners();
      }
      else if(response.statusCode == 401){
        Utils().logoutUser(context);
      }
      else {
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
    paymentHistory(context, dates);
    date = dates;
    notifyListeners();
  }

  void onClear(context, dates) {
    date = "";
    paymentHistory(
      context,
      dates,
    );
    notifyListeners();
  }
}
