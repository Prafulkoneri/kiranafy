import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_my_subscription/view/s_my_subscription_plans_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/view/s_shop_configuration_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/model/apply_referal_code_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/model/s_buy_subscription_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/model/s_subscription_plans_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/repository/apply_referal_code_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/repository/s_buy_subscription_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/repository/subscription_plan_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SSubscriptionController extends ChangeNotifier {
  SubscriptionPlansRepo subscriptionPlansRepo = SubscriptionPlansRepo();
  ReferlCodeRepo referlcodeRepo = ReferlCodeRepo();
  TextEditingController transactionIdController = TextEditingController();
  TextEditingController applyreferalCodeController = TextEditingController();
  ShopBuySubscriptionsRepo shopBuySubscriptionsRepo =
      ShopBuySubscriptionsRepo();
  List<SubscriptionData>? subscriptionData;
  List<AddOnServicesList>? addOnServicesList;
  List<bool> selectAddonServicesList = [];
  List selectedAddOnServicesId = [];
  String selectedId = "";
  List radioValue = [];
  String radioGrpValue = "1";
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
  String? amount;
  Future<void> initState(context) async {
    await getSubscriptionPlanDetails(context);
    applyReferCode(context);
    transactionIdController.clear();
    applyreferalCodeController.clear();
    // radioGrpValue = "1";
    paymentMode = "0";
    selectedServicesId = "0";
    selectPaymentMode = "0";
    isSelectedPaymentUpi = false;
    isQrCodeSeleted = false;
    // onPaymentModeSelected(value);
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

  // void onTimeShopSetup() {
  //   oneTimeShop = !oneTimeShop;
  //   notifyListeners();
  // }
  //
  // void onProductPrice() {
  //   productPrice = !productPrice;
  //   notifyListeners();
  // }
  //
  // void onShopDigital() {
  //   shopDigital = !shopDigital;
  //   notifyListeners();
  // }

  // void onPrimeCatchy() {
  //   primeCatchy = !primeCatchy;
  //   notifyListeners();
  // }

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
          radioValue.add(subscriptionData?[i].id.toString());
        }
        radioGrpValue = radioValue[0];
        selectedPlanId = radioGrpValue;
        print("sfsfsdfsfsdf");
        print(radioValue);
        print(radioGrpValue);
        print("sfsfsdfsfsdf");
        showLoader(false);
        notifyListeners();
      } else if (response.statusCode == 401) {
        Utils().logoutUser(context);
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
    LoadingOverlay.of(context).show();
    shopBuySubscriptionsRepo
        .buySubScription(
            buySubscriptionRequestModel, pref.getString("successToken"))
        .then((response) async {
      final result =
          BuySubscriptionResponseModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        final read = Provider.of<SMainScreenController>(context, listen: false);
        LoadingOverlay.of(context).hide();
        if (loggedIn) {
          read.onNavigation(
              4, SMySubscriptionView(screenName: "accounts"), context);
          read.showBottomNavigationBar();
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => SMainScreenView(
          //           index: 4,
          //           screenName: SMySubscriptionView(screenName: "accounts"))),
          //   (Route<dynamic> route) => false,
          // );
        } else {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString('status', 'subscriptionCompleted');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SShopConfigurationView(initialShopConfigration: true)));
          notifyListeners();
        }
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
    print(value);
    radioGrpValue = value.toString();
    print(radioGrpValue);
    planAmount = price.toString();
    selectedPlanId = id.toString();
    notifyListeners();
  }

  void spaymentMode(value) {
    paymentMode = value;

    notifyListeners();
  }

  void onPaymentModeSelected(value) {
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

  ApplyReferalCodeReqModel get applyReferalCodeReqModel =>
      ApplyReferalCodeReqModel(referalCode: applyreferalCodeController.text);
  Future<void> applyReferCode(context) async {
    LoadingOverlay.of(context).show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    referlcodeRepo
        .referCodeApply(
            applyReferalCodeReqModel, pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result = ApplyRefResmodel.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        if (result.status == 200) {
          amount = result.amount;
          LoadingOverlay.of(context).hide();
          notifyListeners();
        } else {
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
          LoadingOverlay.of(context).hide();
        }
      } else if (response.statusCode == 401) {
        Utils().logoutUser(context);
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
