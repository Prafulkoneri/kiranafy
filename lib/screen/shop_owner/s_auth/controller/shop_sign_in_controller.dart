import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/check_mob_no_exist_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/login_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/mobile_no_register_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/repository/check_mob_no_exist_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/repository/mob_no_register_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/repository/shop_login_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/repository/shop_owner_register_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/view/shop_registration_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/view/shop_sign_in_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/view/s_dash_board_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/view/s_kyc_verification_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopSignInController extends ChangeNotifier {
  CheckMobileNoExistRepo checkMobileNoExistRepo = CheckMobileNoExistRepo();
  MobileNoRegisterRepo mobileNoRegisterRepo = MobileNoRegisterRepo();
  ShopLoginRepo shopLoginRepo = ShopLoginRepo();

  bool isVerifyChecked = false;
  TextEditingController mobController = TextEditingController();
  OtpFieldController otpController = OtpFieldController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationID = "";
  String countryCode = "+91";
  String message = "";
  String otpCode = "";
  bool isLoginBtnEnabled = false;
  bool isNewShopBtnEnabled = false;
  String kycVerificationStatus = "";
  String shopRegistrationStatus = "";
  bool isOtpErrorVisible = false;

  void onOtpSubmitPressed(context) async {
    await mobileRegister(context);
  }

  Future<void> onNewShopPressed(context) async {
    if (mobController.text.length < 10) {
      Utils.showPrimarySnackbar(context, "Please Enter Mobile Number",
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
    if (!isNewShopBtnEnabled) {
      Utils.showPrimarySnackbar(context, "The Number is Already Registered",
          type: SnackType.success);
      return;
    }
    await _auth.verifyPhoneNumber(
        phoneNumber: "$countryCode${mobController.text}",
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
    if (mobController.text.trim().length == 10) {
      await checkMobileNoExistRepo
          .checkMobileNoExist(_checkMobNoExistReqModel)
          .then((response) {
        print(response.body);
        final result =
            CheckMobNoExistResModel.fromJson(jsonDecode(response.body));

        if (response.statusCode == 200) {
          print(response.body);
          kycVerificationStatus = result.kycUploaded ?? "";
          shopRegistrationStatus = result.registrationCompleted ?? "";

          print(kycVerificationStatus);
          print(result.kycUploaded);
          print(result.registrationCompleted);
          if (result.registrationCompleted == "yes") {
            isLoginBtnEnabled = true;
            isNewShopBtnEnabled = false;
            print(isNewShopBtnEnabled);
            Utils.showPrimarySnackbar(context, result.message,
                type: SnackType.success);
            notifyListeners();
            return;
          }
          // if (result.kycUploaded == "no" &&
          //     result.registrationCompleted == "yes") {
          //   isLoginBtnEnabled = false;
          //   isNewShopBtnEnabled = true;
          //   Utils.showPrimarySnackbar(context, result.message,
          //       type: SnackType.success);
          //   notifyListeners();
          //   return;
          // }
          else {
            isNewShopBtnEnabled = true;
            isLoginBtnEnabled = false;
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
    }
  }

  void onOtpEntered(value) {
    otpCode = value;
    notifyListeners();
  }

  void SignOutME() async {
    await _auth.signOut();
  }

  ///firbase
  void signInWithPhoneAuthCred(
      AuthCredential phoneAuthCredential, context) async {
    try {
      final authCred = await _auth.signInWithCredential(phoneAuthCredential);

      if (authCred.user != null) {
        if (isLoginBtnEnabled) {
          onLogin(context);
          return;
        } else {
          mobileRegister(context);
        }
      } else {
        showOtpErrorMsg();
        // Utils.showPrimarySnackbar(context,
        //     "The verification code from SMS/TOTP is invalid. Please check and enter the correct verification code again",
        //     type: SnackType.error);
        notifyListeners();
      }
    } on FirebaseAuthException catch (e) {
      print("888");
      showOtpErrorMsg();
      print("888");
      // Utils.showPrimarySnackbar(context, "e.message", type: SnackType.error);
    }
  }

  Future<void> onLoginClick(context) async {
    if (mobController.text.trim().isEmpty) {
      Utils.showPrimarySnackbar(context, "Please Enter Mobile Number",
          type: SnackType.error);
      notifyListeners();
      return;
    }
    if (mobController.text.trim().length < 10) {
      Utils.showPrimarySnackbar(context, "Please Enter Mobile Number",
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
    if (!isLoginBtnEnabled) {
      Utils.showPrimarySnackbar(context, "Please Register as New Shop",
          type: SnackType.info);
      return;
    }
    await _auth.verifyPhoneNumber(
        phoneNumber: "$countryCode${mobController.text}",
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

  MobNoRegisterReqModel get mobNoRegisterReqModel => MobNoRegisterReqModel(
        mobileNo: mobController.text,
        countryCode: countryCode,
      );

  Future<void> mobileRegister(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    mobileNoRegisterRepo
        .mobileNoRegister(mobNoRegisterReqModel)
        .then((response) {
      print(response.body);
      final result = MobNoRegisterResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        pref.setString("countryCode", result.countryCode ?? "");
        pref.setString('mobileNo', result.mobileNo ?? "");
        pref.setString('status', 'numberRegistered');
        print(pref.getString('status'));
        if (kycVerificationStatus == "no" && shopRegistrationStatus == "yes") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SKycVerificationView()));
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ShopRegistrationView()));
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
  }

  LoginReqModel get loginReqModel => LoginReqModel(
        countryCode: countryCode,
        mobileNo: mobController.text,
      );

  Future<void> onLogin(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    shopLoginRepo.shopLogin(loginReqModel).then((response) {
      final result = LoginResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        pref.setString("successToken", result.successToken?.token ?? "");
        pref.setString("status", "loggedIn");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SMainScreenView(index: 0, screenName: ShopDashBoardView(refresh: true,))),
          (Route<dynamic> route) => false,
        );
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
