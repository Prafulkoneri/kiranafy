import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/auth/model/mobile_number_check_model.dart';
import 'package:local_supper_market/screen/customer/auth/repository/mobile_number_check_repo.dart';
import 'package:local_supper_market/screen/customer/auth/view/customer_sign_in_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/utils/Utils.dart';

class CustomerSignInController extends ChangeNotifier {
  TextEditingController mobileController = TextEditingController();
  MobileNumberCheckRepo mobileNumberCheckRepo = MobileNumberCheckRepo();
  String countryCode = "+91";
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isVerifyChecked = false;
  String otpCode = "";
  String verificationID = "";
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

  void onOtpEntered(value) {
    otpCode = value;
    notifyListeners();
  }

  void onCountryCodeSelected(value) {
    countryCode = value.toString();
  }

  //mobile Number Check

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
////End Mobile Number Check

  Future<void> onNextClick(context) async {
    if (mobileController.text.length < 10) {
      Utils.showPrimarySnackbar(context, "Please Enter Mobile No",
          type: SnackType.error);
      notifyListeners();
      return;
    }

    if (!isLoginBtnEnabled) {
      Utils.showPrimarySnackbar(context, "Please Sign Up",
          type: SnackType.success);
      return;
    }
    // await _auth.verifyPhoneNumber(
    //     phoneNumber: "$countryCode${mobileController.text}",
    //     verificationCompleted: (phoneAuthCredential) async {},
    //     verificationFailed: (verificationFailed) {
    //       Utils.showPrimarySnackbar(context, verificationFailed,
    //           type: SnackType.error);
    //     },
    //     // codeSent: (verificationID, resendingToken) async {
    //     //   LoginScreen.SHOW_OTP_FORM_WIDGET;
    //     //   this.verificationID = verificationID;
    //     // },
    //     codeAutoRetrievalTimeout: (verificationID) async {});
  }
}
