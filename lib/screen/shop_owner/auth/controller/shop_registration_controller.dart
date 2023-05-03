import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/view/s_kyc_verification_view.dart';

class ShopRegistrationController extends ChangeNotifier{
  TextEditingController mobController =TextEditingController();

  void onOtpSubmitBtnPressed(context){
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              SKycVerificationView()),
    );
  }
}