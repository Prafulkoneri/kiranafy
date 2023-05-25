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
  ShopBuySubscriptionsRepo shopBuySubscriptionsRepo =
      ShopBuySubscriptionsRepo();
  List<SubscriptionData>? subscriptionData;
  List<AddOnServicesList>? addOnServicesList;
  List<bool> selectAddonServicesList = [];
  List selectedAddOnServicesId = [];
  String selectedId = "";
  List radioValue = [];
  String radioGrpValue = "0";
  String selectedPlanId = "0";
  String selectedServicesId = "0";
  bool oneTimeShop = false;
  bool productPrice = false;

  bool shopDigital = false;
  bool primeCatchy = false;
  String planAmount = "";

  Future<void> initState(context) async {
    await getSubscriptionPlanDetails(context);
  }

  void onAddOnServicesSelected(index, id) {
    selectAddonServicesList[index] = !selectAddonServicesList[index];
    if (selectAddonServicesList[index]) {
      selectedAddOnServicesId.removeWhere((item) => item == id);
      selectedAddOnServicesId.insert(0, id);
    } else {
      selectedAddOnServicesId.removeWhere((item) => item == id);
    }
    print(selectedAddOnServicesId);
    notifyListeners();
  }

  void onMakePaymentClicked(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SMainScreenView()));
  }

  void onTimeShopSetup() {
    oneTimeShop = !oneTimeShop;
    notifyListeners();
  }

  void onProductPrice() {
    productPrice = !productPrice;
    notifyListeners();
  }

  void onShopDigital() {
    shopDigital = !shopDigital;
    notifyListeners();
  }

  void onPrimeCatchy() {
    primeCatchy = !primeCatchy;
    notifyListeners();
  }

  Future<void> getSubscriptionPlanDetails(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    subscriptionPlansRepo
        .getSubscriptionPlans(pref.getString("successToken"))
        .then((response) {
      print("successToken");
      final result =
          ShopSubscriptionPlansResModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        subscriptionData = result.subscriptionData;
        addOnServicesList = result.addOnServicesList;
        selectAddonServicesList = List<bool>.filled(
            addOnServicesList?.length ?? 0, false,
            growable: true);
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
          subscriptionId: selectedPlanId, serviceId: selectedServicesId);

  Future<void> buySubscriptionPlan(context) async {
    if (selectedAddOnServicesId.isNotEmpty) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String a = '';
      for (int i = 0; i < selectedAddOnServicesId.length; i++) {
        a += "${selectedAddOnServicesId[i]},";
      }
      a = a.substring(0, a.length - 1);
      selectedServicesId = a;

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
    } else {
      Utils.showPrimarySnackbar(context, "Please Select Add On Services",
          type: SnackType.error);
    }
  }

  void onRadioBtnChanged(value, id, price) {
    radioGrpValue = value;
    planAmount = price.toString();
    selectedPlanId = id.toString();
    notifyListeners();
  }
}
