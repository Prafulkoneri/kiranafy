import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_my_subscription/model/get_subscription_history_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_my_subscription/repository/get_subscription_history_repo.dart';

import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubscriptionHistoryController extends ChangeNotifier {
  SubscriptionHistoryRepo subscriptionHistoryRepo = SubscriptionHistoryRepo();
  bool isLoading = true;
  SubcriptionData? subscriptiondata;
  CurrentSubscriptionPlan? currentSubscriptionPlan;
  List<SubscriptionHistory>? subscriptionHistory;
  int selectedIndex = 0;

  Future<void> initState(
    context,
  ) async {
    await getSubscriptionPaymentHistory(
      context,
    );
    notifyListeners();
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getSubscriptionPaymentHistory(context) async {
    showLoader(true);
    print("loading");
    SharedPreferences pref = await SharedPreferences.getInstance();
    subscriptionHistoryRepo
        .subscriptionHistory(pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result =
          GetSubscriptionHistoryModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        subscriptiondata = result.subscriptiondata;
        currentSubscriptionPlan = subscriptiondata?.currentSubscriptionPlan;
        subscriptionHistory = subscriptiondata?.subscriptionHistory;
        showLoader(false);
        notifyListeners();
      } else {
        showLoader(false);
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
