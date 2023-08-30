import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:local_supper_market/screen/customer/c_setting/repository/change_setting_repo.dart';
import 'package:local_supper_market/screen/customer/c_setting/repository/delete_account_repo.dart';
import 'package:local_supper_market/screen/customer/c_setting/repository/setting_repo.dart';
import 'package:local_supper_market/screen/on_boarding/view/on_boarding_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_setting/model/change_setting_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_setting/model/delete_account_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_setting/model/get_setting_model.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerSettingController extends ChangeNotifier {
  CustomerSetingRepo settingRepo = CustomerSetingRepo();
  CDeleteAccountRepo cdeleteAccountRepo = CDeleteAccountRepo();
  bool isAppNotificationEnable = true;
  bool isStackLoading = false;
  bool isLoading = true;
  // String? selectedValue;
// Group Value fo
// r Radio Button.
  Future<void> initState(context) async {
    await shopNotification(context, "");

    notifyListeners();
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> shopNotification(context, status) async {
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    settingRepo.shopSetting(pref.getString("successToken")).then((response) {
      print("444444444");
      print(response.body);
      print("444444444");
      final result = SettingsModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        isAppNotificationEnable =
            result.settingData?.appNotification == "on" ? true : false;
        showLoader(false);
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

  ////////////////////////////
  CustomerChangeSettingRepo changeSettingRepo = CustomerChangeSettingRepo();
  ChangeSettingsRequestModel get changeSettingRequestModel =>
      ChangeSettingsRequestModel(
          appNotification: isAppNotificationEnable ? "on" : "off");

  Future<void> changeSettings(context, value) async {
    LoadingOverlay.of(context).show();
    isAppNotificationEnable = value;
    SharedPreferences pref = await SharedPreferences.getInstance();
    changeSettingRepo
        .changeSetting(
            changeSettingRequestModel, pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result =
          ChangeSettingsResponseModel.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        LoadingOverlay.of(context).hide();
        // Utils.showPrimarySnackbar(context, result.message,
        //     type: SnackType.success);
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

  /////////////////////////SHOP DELETE///////////////////
  Future<void> CustomerAccountDelete(context) async {
    LoadingOverlay.of(context).show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    cdeleteAccountRepo
        .cdeleteAccount(pref.getString("successToken"))
        .then((response) {
      final result = DeleteAccountResModel.fromJson(
        jsonDecode(response.body),
      );
      if (response.statusCode == 200) {
        pref.clear();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OnBoardingScreenView()),
        );
        LoadingOverlay.of(context).hide();
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
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
