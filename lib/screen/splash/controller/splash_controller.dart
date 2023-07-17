import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/home/view/home_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/on_boarding/view/on_boarding_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/view/shop_registration_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/view/s_dash_board_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/view/s_kyc_verification_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_setting/model/app_version_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_setting/repository/app_version_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/view/s_shop_configuration_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/view/s_subscription_view.dart';
import 'package:local_supper_market/screen/update/view/update_view.dart';
import 'package:local_supper_market/utils/utils.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashController extends ChangeNotifier {
  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );
  AppVersionRepo appVersionRepo = AppVersionRepo();
  String appVersion = "";
  bool isUpdateRequired = false;
  AppVersionData? appversiondata;
  Future<void> initState(context) async {
    initPackageInfo();
    await appVersionCheck(context);
    Timer(Duration(seconds: 3), () async {
      if (isUpdateRequired) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UpdateView()),
        );
        return;
      }
      SharedPreferences pref = await SharedPreferences.getInstance();
      print(pref.getString("status"));
      if (pref.getString("status") == "numberRegistered") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ShopRegistrationView()));
      }
      if (pref.getString("status") == "shopRegistered") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SKycVerificationView()));
      }
      if (pref.getString("status") == "kycUploaded") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SSubscriptionScreenView(loggedIn: false)));
      }
      if (pref.getString("status") == "subscriptionCompleted") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SShopConfigurationView(initialShopConfigration: true)));
      }
      if (pref.getString("status") == "loggedIn") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => SMainScreenView(
                    index: 0,
                    screenName: ShopDashBoardView(
                      refresh: true,
                    ),
                  )),
          (Route<dynamic> route) => false,
        );
      }
      if (pref.getString("status") == "customerLoggedIn") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => MainScreenView(
                  index: 0,
                  screenName: HomeScreenView(
                    refreshPage: true,
                  ))),
          (Route<dynamic> route) => false,
        );
      }
      if (pref.getString("status") == null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => OnBoardingScreenView()));
      }

      if (isUpdateRequired) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const UpdateView()),
        );
        return;
      } else {
        SharedPreferences pref = await SharedPreferences.getInstance();
        print(pref.getString("status"));
        if (pref.getString("status") == "numberRegistered") {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => ShopRegistrationView()));
        }
        if (pref.getString("status") == "shopRegistered") {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => SKycVerificationView()));
        }
        if (pref.getString("status") == "kycUploaded") {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SSubscriptionScreenView(loggedIn: false)));
        }
        if (pref.getString("status") == "subscriptionCompleted") {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SShopConfigurationView(initialShopConfigration: true)));
        }
        if (pref.getString("status") == "loggedIn") {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => SMainScreenView(
                      index: 0,
                      screenName: ShopDashBoardView(
                        refresh: true,
                      ),
                    )),
            (Route<dynamic> route) => false,
          );
        }
        if (pref.getString("status") == "customerLoggedIn") {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => MainScreenView(
                    index: 0,
                    screenName: HomeScreenView(
                      refreshPage: true,
                    ))),
            (Route<dynamic> route) => false,
          );
        }
        if (pref.getString("status") == null) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => OnBoardingScreenView()));
        }
      }
    });
  }

  Future<void> initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    packageInfo = info;
  }

  Future<void> appVersionCheck(context) async {
    initPackageInfo();
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    appVersionRepo.appVersion(pref.getString("successToken")).then((response) {
      print(response.body);
      final result = AppVersionModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(packageInfo.version);
        print("jjjjjjjjjjjjjjjjjjjjjjjj");
        appversiondata = result.appversiondata;
        if (packageInfo.version != appversiondata?.appVersion) {
          print("true");
          isUpdateRequired = true;
          notifyListeners();
        }

        // isAppNotificationEnable =
        //     result.settingData?.appNotification == "on" ? true : false;
        // Utils.showPrimarySnackbar(context, result.message,
        //     type: SnackType.success);

        else {
          isUpdateRequired = false;
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
