import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/auth/model/mobile_number_check_model.dart';
import 'package:local_supper_market/screen/customer/auth/repository/mobile_number_check_repo.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/utils/Utils.dart';

class CustomerSignInController extends ChangeNotifier {
  TextEditingController mobileController = TextEditingController();
  MobileNumberCheckRepo mobileNumberCheckRepo = MobileNumberCheckRepo();
  String countryCode = "+91";
  bool isVerifyChecked = false;
  bool isLoginBtnEnabled = false;
  void onOtpSubmitPressed(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MainScreenView()),
    );
  }

  void onVerifyChecked(value) {
    isVerifyChecked = value;
    notifyListeners();
  }

  void onCountryCodeSelected(value) {
    countryCode = value.toString();
  }

  MobileNumberCheckRequestModel get mobileNumberCheckRequestModel =>
      MobileNumberCheckRequestModel(
        mobileNo: mobileController.text,
        countryCode: countryCode,
      );

  Future<void> mobileNumberCheck(context) async {
    if (mobileController.text.length == 10) {
      await mobileNumberCheckRepo
          .mobileNumberCheck(mobileNumberCheckRequestModel)
          .then((response) {
        print(response.body);
        final result =
            MobileNumberCheckResponseModel.fromJson(jsonDecode(response.body));

        if (response.statusCode == 200) {
          print(response.body);
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

  Future<void> onNextClick(context) async {
    if (mobileController.text.length < 10) {
      Utils.showPrimarySnackbar(context, "Please Enter Mobile No",
          type: SnackType.error);
      notifyListeners();
      return;
    }
    // if (!isVerifyChecked) {
    //   Utils.showPrimarySnackbar(context, "Please agree our terms and condition",
    //       type: SnackType.error);
    //   notifyListeners();
    //   return;
    // }
    if (!isLoginBtnEnabled) {
      Utils.showPrimarySnackbar(context, "Please Sign Up",
          type: SnackType.success);
      return;
    }
  }
}
