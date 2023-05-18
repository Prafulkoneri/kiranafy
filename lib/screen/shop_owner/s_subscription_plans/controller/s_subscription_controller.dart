import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/model/s_buy_subscription_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/model/s_subscription_plans_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/repository/s_buy_subscription_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/repository/subscription_plan_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/view/s_subscription_view.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SSubscriptionController extends ChangeNotifier {
  SubscriptionPlansRepo subscriptionPlansRepo = SubscriptionPlansRepo();
  ShopBuySubscriptionsRepo shopBuySubscriptionsRepo = ShopBuySubscriptionsRepo();
  List<SubscriptionData>? subscriptionData;
  List radioValue = [];
  String radioGrpValue = "0";
  String selectedPlanId = "0";

  Future<void> initState(context) async {
    await getSubscriptionPlanDetails(context);
  }

  // void onMakePaymentClicked(context) {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => SMainScreenView()));
  // }

  Future<void> getSubscriptionPlanDetails(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    subscriptionPlansRepo
        .getSubscriptionPlans(pref.getString("successToken"))
        .then((response) {
      final result =
          ShopSubscriptionPlansResModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        subscriptionData = result.subscriptionData;
        int length = subscriptionData?.length ?? 0;
        radioValue.clear();
        for (int i = 0; i < length; i++) {
          radioValue.add(i.toString());
        }
        print(radioValue);
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

  BuySubscriptionRequestModel get buySubscriptionRequestModel =>
      BuySubscriptionRequestModel(
        subscriptionId: selectedPlanId,
      );

  Future<void> buySubscriptionPlan(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    shopBuySubscriptionsRepo
        .buySubScription(
            buySubscriptionRequestModel, pref.getString("successToken"))
        .then((response) {
      final result =
          BuySubscriptionResponseModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
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

  void onRadioBtnChanged(value, id) {
    radioGrpValue = value.toString();
    selectedPlanId = id.toString();
    notifyListeners();
  }
}
