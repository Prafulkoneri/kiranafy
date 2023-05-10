import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/check_mob_no_exist_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/repository/check_mob_no_exist_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/view/shop_registration_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';

class ShopSignInController extends ChangeNotifier {
  CheckMobileNoExistRepo checkMobileNoExistRepo = CheckMobileNoExistRepo();

  bool isVerifyChecked = false;
  TextEditingController mobController = TextEditingController();
  String countryCode = "+91";
  String message = "";

  void onOtpSubmitPressed(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SMainScreenView()));
  }

  void onNewShopPressed(context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ShopRegistrationView()));
  }

  void onVerifyChecked(value) {
    isVerifyChecked = value;
    notifyListeners();
  }

  void onCountryCodeSelected(value) {
    countryCode = value.toString();
  }

  CheckMobNoExistReqModel get _checkMobNoExistReqModel =>
      CheckMobNoExistReqModel(
        mobileNo: mobController.text,
        countryCode: countryCode,
      );

  Future<void> checkMobNoExist(context) async {
    await checkMobileNoExistRepo
        .checkMobileNoExist(_checkMobNoExistReqModel)
        .then((response) {
          print(mobController.text);
          print(countryCode);
      if (mobController.text.length == 10) {
        print(response.body);
        if (response.statusCode == 200) {
          final result = CheckMobNoExistResModel.fromJson(jsonDecode(response.body));
          debugPrint("checkMobNoExist ${response.body}");
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));
          message = result.message ?? "";
        }
      }
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
  }
}
