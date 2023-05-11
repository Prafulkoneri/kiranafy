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
import 'package:local_supper_market/screen/shop_owner/s_auth/model/mobile_no_register_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/repository/check_mob_no_exist_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/repository/mob_no_register_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/view/shop_registration_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/view/shop_sign_in_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/view/s_dash_board_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:otp_text_field/otp_text_field.dart';

class ShopSignInController extends ChangeNotifier {
  CheckMobileNoExistRepo checkMobileNoExistRepo = CheckMobileNoExistRepo();
  MobileNoRegisterRepo mobileNoRegisterRepo = MobileNoRegisterRepo();

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
  String kycVerificationStatus="";


  void onOtpSubmitPressed(context)async {
    await mobileRegister(context);
  }

  Future<void> onNewShopPressed(context)async{
  if(!isNewShopBtnEnabled){
    Utils.showPrimarySnackbar(context,"The Number is Already Registered",
        type: SnackType.success);
  }
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
      final result =
          CheckMobNoExistResModel.fromJson(jsonDecode(response.body));
      if (mobController.text.length == 10) {
        if (response.statusCode == 200) {
          kycVerificationStatus=result.kycUploaded??"";
          print(kycVerificationStatus);
          print(result.kycUploaded);
          print(result.registrationCompleted);
          if (result.kycUploaded == "yes" &&
              result.registrationCompleted=="yes") {
            isLoginBtnEnabled = true;
            isNewShopBtnEnabled = false;
            print(isNewShopBtnEnabled);
            Utils.showPrimarySnackbar(context, result.message,
                type: SnackType.success);
            notifyListeners();
            return;
          }
          if(result.kycUploaded=="no" && result.registrationCompleted=="yes"){
            isLoginBtnEnabled = false;
            isNewShopBtnEnabled = true;
            Utils.showPrimarySnackbar(context, result.message,
                type: SnackType.success);
            notifyListeners();
            return;

          }
          else{
            isNewShopBtnEnabled=true;
            isLoginBtnEnabled=false;
            notifyListeners();
          }
        } else {
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
        }
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

  void onOtpEntered(value) {
    otpCode = value;
    notifyListeners();
  }

  void SignOutME() async {
    await _auth.signOut();
  }

  void signInWithPhoneAuthCred(
      AuthCredential phoneAuthCredential, context) async {
    try {
      final authCred = await _auth.signInWithCredential(phoneAuthCredential);

      if (authCred.user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ShopDashBoard()));
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Some Error Occured. Try Again Later')));
    }
  }

  Future<void> onLoginClick(context) async {
    if(!isLoginBtnEnabled){
      Utils.showPrimarySnackbar(context,"Please Sign Up",
          type: SnackType.success);
      return;
    }
    await _auth.verifyPhoneNumber(
        phoneNumber: "$countryCode${mobController.text}",
        verificationCompleted: (phoneAuthCredential) async {},
        verificationFailed: (verificationFailed) {
          print(verificationFailed);
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

  MobNoRegisterReqModel get mobNoRegisterReqModel=>MobNoRegisterReqModel(
    mobileNo: mobController.text,
    countryCode: countryCode,
  );

  Future<void> mobileRegister(context)async{
    mobileNoRegisterRepo.mobileNoRegister(mobNoRegisterReqModel).then((response){
      final result = MobNoRegisterResModel.fromJson(jsonDecode(response.body));
        if (response.statusCode == 200) {
         Navigator.push(context,MaterialPageRoute(builder: (context)=>ShopRegistrationView()));
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
