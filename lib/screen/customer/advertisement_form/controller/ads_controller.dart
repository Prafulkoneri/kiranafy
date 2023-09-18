import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/advertisement_form/model/c_ads_model.dart';
import 'package:local_supper_market/screen/customer/advertisement_form/repository/c_ads_repo.dart';
import 'package:local_supper_market/screen/customer/home/view/home_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';

import 'package:local_supper_market/screen/shop_owner/promotion_request/model/promotion_request_model.dart';
import 'package:local_supper_market/screen/shop_owner/promotion_request/repository/promotion_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class customerAdscontroller extends ChangeNotifier {
  String groupValue = "7";
  bool isLoading = true;
  bool isStackLoading = false;
  TextEditingController adsNameController = TextEditingController();
  TextEditingController adsMobileNumberController = TextEditingController();
  TextEditingController adsShopNamecontroller = TextEditingController();
  TextEditingController planToStartController = TextEditingController(); //
  TextEditingController adsContentController = TextEditingController(); //
  CPraqmotionRequestRepo cadsRequestRepo = CPraqmotionRequestRepo();

  void showStackLoader(value) {
    isStackLoading = value;
    notifyListeners();
  }

  void showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  CustomerAdsRequestmodel get customerAdsrequestModel =>
      CustomerAdsRequestmodel( name: adsNameController.text,shopName: adsShopNamecontroller.text,
        number: adsMobileNumberController.text,
          adsPlan: groupValue,
          adsContent: adsContentController.text,
        planStartDateFrom: planToStartController.text,

      );

  Future<void> customerAdsForm(context) async {
    if (adsNameController.text == "") {
      Utils.showPrimarySnackbar(context, "Please Enter Name",
          type: SnackType.error);
      return;
    }
    if (adsMobileNumberController.text == "") {
      Utils.showPrimarySnackbar(context, "Please Enter Contact No",
          type: SnackType.error);
      return;
    }
    if (adsShopNamecontroller.text == "") {
      Utils.showPrimarySnackbar(context, "Please Enter Shop Name",
          type: SnackType.error);
      return;
    }
    if (planToStartController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter  Date", type: SnackType.error);
      return;
    }
    if (adsContentController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter Ads Content",
          type: SnackType.error);
      return;
    }

    if (groupValue == "") {
      Utils.showPrimarySnackbar(context, "Select Ads Plan",
          type: SnackType.error);
      return;
    }
    LoadingOverlay.of(context).show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    cadsRequestRepo.cpramotionRequest(customerAdsrequestModel,  pref.getString("successToken"))

        .then((response) {
      print(response.body);
      final result =
      CustomerAdsResponsemodel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        groupValue = "";
        adsNameController.clear();
        adsShopNamecontroller.clear();
        adsMobileNumberController.clear();
        planToStartController.clear();
        adsContentController.clear();
        final read=Provider.of<MainScreenController>(context,listen: false);
        read.onNavigation(0, HomeScreenView(
          refreshPage: true,
        ), context);
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => MainScreenView(
        //           index: 4,
        //           screenName: HomeScreenView(
        //          refreshPage: true,
        //           ))),
        //       (Route<dynamic> route) => false,
        // );
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
        print(response.body);
        LoadingOverlay.of(context).hide();
        notifyListeners();
      } else {
        LoadingOverlay.of(context).hide();
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

  void onToDateSelected(date) {
    planToStartController.text = date;
    notifyListeners();
  }

  void onRadioBtnToggled(value) {
    groupValue = value;
    notifyListeners();
  }
}
