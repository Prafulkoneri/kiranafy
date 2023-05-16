import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/model/s_buy_subscription_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/model/s_subscription_plans_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/repository/s_buy_subscription_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/repository/subscription_plan_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SSubscriptionController extends ChangeNotifier {
  SubscriptionPlansRepo subscriptionPlansRepo = SubscriptionPlansRepo();
  ShopBuySubscriptionsRepo buySubscriptionPlansRepo =
      ShopBuySubscriptionsRepo();
  List<SubscriptionData>? subscriptionData;
  String buySubScriptionId = "";
  bool isFirstServices = false;
  bool isSecondServices = false;
  bool isThreeServices = false;
  bool isFourServices = false;

  ///
  void onClickFirstServices() {
    isFirstServices = !isFirstServices;
    notifyListeners();
  }

  void onClickSecondServices() {
    isFirstServices = !isFirstServices;
    notifyListeners();
  }

  void onClickThreeServices() {
    isFirstServices = !isFirstServices;
    notifyListeners();
  }

  void onClickFourServices() {
    isFirstServices = !isFirstServices;
    notifyListeners();
  }

  ///
  Future<void> initState(context) async {
    await getSubscriptionPlanDetails(context);
  }

  Future<void> getSubscriptionPlanDetails(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    subscriptionPlansRepo
        .getSubscriptionPlans("13|ZJNBiPqRfUTu81IUmu57lK6nCrC1DjWRpQvqZTk2")
        .then((response) {
      final result =
          ShopSubscriptionPlansResModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        subscriptionData = result.subscriptionData;
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

  ////////////////////buy subsciption start///////////
  ///
  ///
  ///

  void onSubscriptionSelect(id) {
    buySubScriptionId = id;
    notifyListeners();
  }

  BuySubscriptionRequestModel get shopUpdateProfileReqModel =>
      BuySubscriptionRequestModel(subscriptionId: buySubScriptionId);

  Future<void> BuySubscription(context) async {
    buySubscriptionPlansRepo.BuySubScription(shopUpdateProfileReqModel)
        .then((response) {
      final result =
          BuySubscriptionResponseModel.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SMainScreenView()));

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
