import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';

class CustomerSignUpController extends ChangeNotifier {
  TextEditingController mobileController = TextEditingController();
  bool isVerifyChecked = false;

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
}
