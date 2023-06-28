import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_payments/model/payment_history_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_payments/repositotry/payment_history_repo.dart';

import 'package:local_supper_market/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentHistoryController extends ChangeNotifier {
  String date = "";
  PaymentHistoryData? paymentdata;
  List<OrdersList>? ordersList;
  int? currentMonthCollection;
  int? totalBusiness;
  Future<void> initState(context, dates) async {
    await paymentHistory(context, dates);

    notifyListeners();
  }

  PaymentHistoryRepo paymentHistoryRepo = PaymentHistoryRepo();
  PaymentHistoaryRequestModel get paymentHistoryRequestModel =>
      PaymentHistoaryRequestModel(date: date);
  Future<void> paymentHistory(context, dates) async {
    date = dates;

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
