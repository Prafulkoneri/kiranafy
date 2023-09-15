import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/main.dart';
import 'package:local_supper_market/screen/customer/auth/model/customer_sign_in_model.dart';
import 'package:local_supper_market/screen/customer/auth/model/mobile_number_check_model.dart';
import 'package:local_supper_market/screen/customer/auth/repository/customer_sign_in_repo.dart';
import 'package:local_supper_market/screen/customer/auth/repository/mobile_number_check_repo.dart';
import 'package:local_supper_market/screen/customer/auth/view/customer_sign_up_view.dart';
import 'package:local_supper_market/screen/customer/home/view/home_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerSignInController extends ChangeNotifier {
  TextEditingController mobileController = TextEditingController();
  MobileNumberCheckRepo mobileNumberCheckRepo = MobileNumberCheckRepo();
  CustomerSignInRepo customerSignInRepo = CustomerSignInRepo();
  String countryCode = "+91";
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isOtpErrorVisible = false;
  bool isVerifyChecked = false;
  String otpCode = "";
  String verificationID = "";
  bool isLoginBtnEnabled = false;
  // bool isNextBtnEnabled = false;

  void onOtpSubmitPressed(context) {
    onCodeVerification(context);
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
          if (result.status == 404) {
            isLoginBtnEnabled = false;
            Utils.showPrimarySnackbar(context, result.message,
                type: SnackType.error);
          } else {
            isLoginBtnEnabled = true;
            Utils.showPrimarySnackbar(context, result.message,
                type: SnackType.success);
          }

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
////End Mobile Number Check

  Future<void> onNextClick(context) async {
    if (mobileController.text.length < 10) {
      Utils.showPrimarySnackbar(context, "Please Enter Mobile Number",
          type: SnackType.error);
      notifyListeners();
      return;
    }

    if (!isLoginBtnEnabled) {
      Utils.showPrimarySnackbar(context, "Please Sign Up",
          type: SnackType.error);
      return;
    }

    await _auth.verifyPhoneNumber(
        phoneNumber: "$countryCode${mobileController.text}",
        verificationCompleted: (phoneAuthCredential) async {},
        verificationFailed: (verificationFailed) {
          Utils.showPrimarySnackbar(context, verificationFailed,
              type: SnackType.error);
        },
        codeSent: (verificationID, resendingToken) async {
          LoginScreen.SHOW_OTP_FORM_WIDGET;
          this.verificationID = verificationID;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-retrieval timeout. Handle this as needed.
        },
        timeout: const Duration(seconds: 60)
        // codeAutoRetrievalTimeout: (verificationID) async {}
        );
  }

  CustomerSignInReqModel get customerSignInReqModel => CustomerSignInReqModel(
      customerCountryCode: countryCode,
      customerMobileNo: mobileController.text,
      customerFcmToken: fcmToken);

  Future<void> onsignIn(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    customerSignInRepo.customerSignIn(customerSignInReqModel).then((response) {
      final result = CustomerSignInResModel.fromJson(jsonDecode(response.body));
      print("888888");
      log(response.body);
      print("888888");
      if (response.statusCode == 200) {
        pref.setString("successToken", result.successToken?.token ?? "");
        pref.setString("status", "customerLoggedIn");
        print("token ${pref.getString("successToken")}");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MainScreenView(
                      index: 0,
                      screenName: HomeScreenView(refreshPage: true),
                    )));
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

  void signInWithPhoneAuthCred(
      AuthCredential phoneAuthCredential, context) async {
    try {
      final authCred = await _auth.signInWithCredential(phoneAuthCredential);
      if (authCred.user != null) {
        onsignIn(context);
      } else {
        showOtpErrorMsg();
        notifyListeners();
        // Utils.showPrimarySnackbar(context,
        //     "The verification code from SMS/TOTP is invalid. Please check and enter the correct verification code again",
        //     type: SnackType.error);
      }
    } on FirebaseAuthException catch (e) {
      print("888");
      showOtpErrorMsg();
      print("888");
      Utils.showPrimarySnackbar(context, "e.message", type: SnackType.error);
    }
  }

  Future<void> onCodeVerification(context) async {
    AuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpCode);
    signInWithPhoneAuthCred(phoneAuthCredential, context);
  }

  showOtpErrorMsg() {
    isOtpErrorVisible = true;
    notifyListeners();
    print(isOtpErrorVisible);
    Timer(Duration(seconds: 3), () {
      print("duration");
      isOtpErrorVisible = false;
      notifyListeners();
    });
  }

  void onOtpDismiss() {
    isOtpErrorVisible = false;
    notifyListeners();
  }
}
