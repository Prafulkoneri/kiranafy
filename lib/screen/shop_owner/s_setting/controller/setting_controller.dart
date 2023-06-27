import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:local_supper_market/screen/shop_owner/s_setting/model/get_setting_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_setting/repository/setting_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopSettingController extends ChangeNotifier {
  SeetingRepo settingRepo = SeetingRepo();
  String? selectedValue;
// Group Value fo
// r Radio Button.
  int id = 1;
  bool switchValue = true;
  bool switchValue1 = true;

  Future<void> initState(context) async {
    await shopNotification(context);
  }

  Future<void> shopNotification(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    settingRepo.shopSetting(pref.getString("successToken")).then((response) {
      print(response.body);
      final result = SettingModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
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
