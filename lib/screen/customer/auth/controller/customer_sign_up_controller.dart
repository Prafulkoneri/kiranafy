import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/utils/utils.dart';

class CustomerSignUpController extends ChangeNotifier {
  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();
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

  Future<void> onNextClick(context) async {
    if (mobileController.text.length < 10) {
      Utils.showPrimarySnackbar(context, "Please Enter Mobile No",
          type: SnackType.error);
      notifyListeners();
      return;
    }
    // if()
    if (!isVerifyChecked) {
      Utils.showPrimarySnackbar(context, "Please agree our terms and condition",
          type: SnackType.error);
      notifyListeners();
      return;
    }
    if (!isLoginBtnEnabled) {
      Utils.showPrimarySnackbar(context, "Please Sign Up",
          type: SnackType.success);
      return;
    }
  }
}
