import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/auth/model/customer_sign_up_model.dart';
import 'package:local_supper_market/screen/customer/auth/model/mobile_number_check_model.dart';
import 'package:local_supper_market/screen/customer/auth/repository/customer_sign_up_repo.dart';
import 'package:local_supper_market/screen/customer/auth/repository/mobile_number_check_repo.dart';
import 'package:local_supper_market/screen/customer/auth/view/customer_sign_up_view.dart';
import 'package:local_supper_market/screen/customer/home/view/home_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerSignUpController extends ChangeNotifier {
  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  CustomerSignUpRepo customerSignUpRepo = CustomerSignUpRepo();
  MobileNumberCheckRepo mobileNumberCheckRepo = MobileNumberCheckRepo();
  bool isOtpErrorVisible = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isVerifyChecked = false; //terms
  String countryCode = "+91";
  // bool isNextBtnEnabled = false;
  bool isLoginBtnEnabled = false;
  String verificationID = "";
  String otpCode = "";

  ///Term And Condition
  void onVerifyChecked(value) {
    isVerifyChecked = value;
    notifyListeners();
  }

// //Country Code
  void onCountryCodeSelected(value) {
    countryCode = value.toString();
  }

  /////NewCustomer
  Future<void> onNextSignClick(context) async {
    if (mobileController.text.length < 10) {
      Utils.showPrimarySnackbar(context, "Please Enter Phone Number",
          type: SnackType.error);
      notifyListeners();
      return;
    }
    if (nameController.text == "") {
      Utils.showPrimarySnackbar(context, "Please Enter Name",
          type: SnackType.error);
      notifyListeners();
      return;
    }
    if (!isVerifyChecked) {
      Utils.showPrimarySnackbar(context, "Please agree our terms and condition",
          type: SnackType.error);
      notifyListeners();
      return;
    }

    if (isLoginBtnEnabled) {
      Utils.showPrimarySnackbar(context, "The Number is Already Registered",
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
        codeAutoRetrievalTimeout: (verificationID) async {});
  }

  Future<void> onCodeVerification(context) async {
    AuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpCode);
    signInWithPhoneAuthCred(phoneAuthCredential, context);
  }

  void signInWithPhoneAuthCred(
      AuthCredential phoneAuthCredential, context) async {
    try {
      final authCred = await _auth.signInWithCredential(phoneAuthCredential);

      if (authCred.user != null) {
        if (isLoginBtnEnabled) {
          onsignUp(context);
          return;
        }

        // onsignUp(context);
      } else {
        showOtpErrorMsg();
        notifyListeners();
        // Utils.showPrimarySnackbar(context,
        //     "The verification code from SMS/TOTP is invalid. Please check and enter the correct verification code again",
        //     type: SnackType.error);
      }
    } on FirebaseAuthException catch (e) {
      // print("888");
      // print(e.message);
      showOtpErrorMsg();
      // print("888");
      // Utils.showPrimarySnackbar(context, "e.message", type: SnackType.error);
    }
  }

  void onOtpEntered(value) {
    otpCode = value;
    notifyListeners();
  }

  CustomerSignUpRequestModel get customerSignupReqModel =>
      CustomerSignUpRequestModel(
          countryCode: countryCode,
          mobileNo: mobileController.text,
          customerName: nameController.text);

  Future<void> onsignUp(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    customerSignUpRepo
        .customerSignUpDetail(customerSignupReqModel)
        .then((response) {
      final result =
          CustomerSignUpResponcesModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        pref.setString("successToken", result.successToken?.token ?? "");
        pref.setString("status", "customerLoggedIn");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainScreenView()));
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

  /////Mobile Number Check
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
