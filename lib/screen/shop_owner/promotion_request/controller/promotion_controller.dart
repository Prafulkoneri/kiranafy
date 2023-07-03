import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:local_supper_market/screen/shop_owner/promotion_request/model/promotion_request_model.dart';
import 'package:local_supper_market/screen/shop_owner/promotion_request/repository/promotion_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class shopPromotionController extends ChangeNotifier {
  String groupValue = "";
  bool isLoading = true;
  bool isStackLoading = false;
  TextEditingController promotionSubjectController = TextEditingController();
  TextEditingController planToStartController = TextEditingController(); //
  TextEditingController adsContentController = TextEditingController(); //
  PraqmotionRequestRepo pramotionRequestRepo = PraqmotionRequestRepo();

  void showStackLoader(value) {
    isStackLoading = value;
    notifyListeners();
  }

  void showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  PromotionRequestRequestModel get pramotionRequestRequestModel =>
      PromotionRequestRequestModel(
          adsPlan: groupValue,
          adsContent: adsContentController.text,
          planStartDateFromShopOwner: planToStartController.text,
          promotionSubject: promotionSubjectController.text);

  Future<void> promotionRequestForm(context) async {
    if (promotionSubjectController.text == "") {
      Utils.showPrimarySnackbar(context, "Please Enter Promotion Subject",
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
    pramotionRequestRepo
        .pramotionRequest(
            pramotionRequestRequestModel, pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result =
          PromotionRequestResponseModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        groupValue = "";
        promotionSubjectController.clear();
        planToStartController.clear();
        adsContentController.clear();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SMainScreenView(index: 4, screenName: SAccountScreenView(refresh: true,))),
          (Route<dynamic> route) => false,
        );
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
