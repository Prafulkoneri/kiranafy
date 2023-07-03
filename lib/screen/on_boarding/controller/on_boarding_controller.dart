import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/auth/view/customer_sign_in_view.dart';
import 'package:local_supper_market/screen/on_boarding/model/on_boarding_response_model.dart';
import 'package:local_supper_market/screen/on_boarding/repository/on_boarding_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/view/shop_sign_in_view.dart';
import 'package:local_supper_market/utils/Utils.dart';

class OnBoardingController extends ChangeNotifier {
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  OnBoardingRepo onBoardingRepo = OnBoardingRepo();
  List<OnboardingData>? onBoardingData;
  bool isLoading = true;

  Future<void> initState(context) async {
    await getOnBoardingData(context);

    notifyListeners();
  }

  void onPageChanged(index) {
    currentIndex = index;
    notifyListeners();
  }

  void onSkipPressed(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CustomerSignInView()));
  }

  void onShopOwnerBtnPressed(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ShopSignInView()));
  }

  void onCustomerBtnPressed(context) {
    // Navigator.push(
        // context, MaterialPageRoute(builder: (context) => CustomerSignInView()));

    Utils.showPrimarySnackbar(context,"This is a pre-launch for shop owner, app for customers will be launched soon!", type: SnackType.success);
    return;
  }

////Function OnBoaring
  Future<void> getOnBoardingData(context) async {
    isLoading = true;

    onBoardingRepo.onBoardingScreen().then((response) {
      print(response.statusCode);
      print(response.body);
      final result =
          OnBoardingResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        print("${response.body}");
        onBoardingData = result.data;
        Timer.periodic(Duration(seconds: 3), (Timer timer) {
          int length = onBoardingData?.length ?? 0;
          if (currentIndex < length) {
            currentIndex++;
            pageController.animateToPage(
              currentIndex,
              duration: Duration(milliseconds: 350),
              curve: Curves.easeIn,
            );
          } else {
            currentIndex = length;
          }
        });
        isLoading = false;
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
