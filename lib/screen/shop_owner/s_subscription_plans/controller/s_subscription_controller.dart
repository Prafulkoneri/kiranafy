import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/view/s_kyc_approved.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/view/s_kyc_completed.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/view/s_shop_configuration_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/model/s_buy_subscription_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/model/s_subscription_plans_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/repository/s_buy_subscription_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/repository/subscription_plan_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/view/s_subscription_view.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SSubscriptionController extends ChangeNotifier {
  SubscriptionPlansRepo subscriptionPlansRepo = SubscriptionPlansRepo();
  TextEditingController transactionIdController = TextEditingController();
  ShopBuySubscriptionsRepo shopBuySubscriptionsRepo =
      ShopBuySubscriptionsRepo();
  List<SubscriptionData>? subscriptionData;
  List<AddOnServicesList>? addOnServicesList;
  List<bool> selectAddonServicesList = [];
  List selectedAddOnServicesId = [];
  String selectedId = "";
  List radioValue = [];
  String radioGrpValue = "0";
  String paymentMode = "";
  String selectedPlanId = "0";
  String selectedServicesId = "0";
  String selectPaymentMode = "0";
  String selectTransactionID = "0";
  bool oneTimeShop = false;
  bool productPrice = false;
  bool isLoading = false;
  bool shopDigital = false;
  bool primeCatchy = false;
  String planAmount = "";
  bool isSelectedPaymentUpi = false;
  bool isQrCodeSeleted = false;

  Future<void> initState(context) async {
    await getSubscriptionPlanDetails(context);
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
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
    showLoader(true);
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
        planAmount = subscriptionData?[0].subscriptionPrice.toString() ?? "";
        selectAddonServicesList = List<bool>.filled(
            addOnServicesList?.length ?? 0, false,
            growable: true);
        int length = subscriptionData?.length ?? 0;
        radioValue.clear();
        for (int i = 0; i < length; i++) {
          radioValue.add(i.toString());
        }
        print(radioValue);
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

  BuySubscriptionRequestModel get buySubscriptionRequestModel =>
      BuySubscriptionRequestModel(
          subscriptionId: selectedPlanId,
          serviceId: selectedServicesId,
          paymentMode: isQrCodeSeleted ? "qr_code" : "upi",
          transactionId: transactionIdController.text);

  Future<void> buySubscriptionPlan(context, loggedIn) async {
    if (!isQrCodeSeleted & !isSelectedPaymentUpi) {
      Utils.showPrimarySnackbar(context, "Please Select Mode Of Payment",
          type: SnackType.error);
      return;
    }
    if (transactionIdController.text.isEmpty) {
      Utils.showPrimarySnackbar(context, "Enter Transaction ID",
          type: SnackType.error);
      return;
    }
    SharedPreferences pref = await SharedPreferences.getInstance();
    String a = '';
    if (selectedAddOnServicesId.isNotEmpty) {
      for (int i = 0; i < selectedAddOnServicesId.length; i++) {
        a += "${selectedAddOnServicesId[i]},";
      }

      a = a.substring(0, a.length - 1);
      selectedServicesId = a;
    } //
    else {
      selectedServicesId = "";
    }

    shopBuySubscriptionsRepo
        .buySubScription(
            buySubscriptionRequestModel, pref.getString("successToken"))
        .then((response) async {
      final result =
          BuySubscriptionResponseModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        // if (loggedIn) {
        //   Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => SMainScreenView(
        //               index: 4,
        //               screenName: SAccountScreenView(),
        //             )),
        //     (Route<dynamic> route) => false,
        //   );
        // } else {
        //
        // }
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('status', 'subscriptionCompleted');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SShopConfigurationView(initialShopConfigration: true)));
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
    // } else {
    //   Utils.showPrimarySnackbar(context, "Please Select Add On Services",
    //       type: SnackType.error);
    // }
  }

  void onRadioBtnChanged(value, id, price) {
    radioGrpValue = value;
    planAmount = price.toString();
    selectedPlanId = id.toString();
    notifyListeners();
  }

  void spaymentMode(value) {
    paymentMode = value;

    notifyListeners();
  }

  void onFavToShopSelected(value) {
    if (!isSelectedPaymentUpi) {
      isSelectedPaymentUpi = true;
      isQrCodeSeleted = false;
    } else {
      isSelectedPaymentUpi = false;
      isQrCodeSeleted = false;
    }
    notifyListeners();
  }

  void onOrderedButNotFavSelected(value) {
    if (!isQrCodeSeleted) {
      isQrCodeSeleted = true;
      isSelectedPaymentUpi = false;
    } else {
      isSelectedPaymentUpi = false;
      isQrCodeSeleted = false;
    }
    notifyListeners();
  }
}
