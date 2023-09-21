import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/account/model/faq_model.dart';

import 'package:local_supper_market/screen/customer/account/model/profile_detail_cmodel.dart';
import 'package:local_supper_market/screen/customer/account/repository/c_profile_repo.dart';
import 'package:local_supper_market/screen/customer/account/repository/faq_repository_repo.dart';
import 'package:local_supper_market/screen/customer/account/repository/sign_out_repo.dart';

import 'package:local_supper_market/screen/customer/favourites/view/favourites_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/my_order/view/my_order_view.dart';
import 'package:local_supper_market/screen/customer/notifications/view/notification_view.dart';
import 'package:local_supper_market/screen/customer/update_profile/view/update_profile_view.dart';
import 'package:local_supper_market/screen/on_boarding/view/on_boarding_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/model/sign_out_model.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends ChangeNotifier {
  CustomerData? customerData;
  CustomerSignOutRepo customerSignOutRepo = CustomerSignOutRepo();
  CustomerFAQDataRepo customerFaqRepo = CustomerFAQDataRepo();
  bool isLoading = true;
  List<CustomerFaqDataList>? customerfaqdataList;
  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> initState(
    context,isRefreshed
  ) async {
    if(isRefreshed){
      await getCustomerProfileDetails(context);
    }

  }

  CustomerProfileRepo customerProfileRepo = CustomerProfileRepo(); ////;
  void onEditProfilePressed(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UpdateProfileView()));
  }

  void myOrdersPressed(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyOrderView()));
  }

  void myNotificationsPressed(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CustomerNotificationsScreenView()));
  }

  void favouritesPressed(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyOrderView()));
  }

  void onLogout(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => OnBoardingScreenView()));
  }

  void onFavouritesClicked(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CFavouritesView()));
  }

////Detail Profile
  Future<void> getCustomerProfileDetails(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    customerProfileRepo
        .getCustomerProfile(pref.getString("successToken"))
        .then((response) {
      final result = CustomerProfileDetailsRes.fromJson(
        jsonDecode(response.body),
      );
      if (response.statusCode == 200) {
        customerData = result.data;
        log("${response.body}");
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

  /////End Detail Profile

  Future<void> customerSignOut(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    customerSignOutRepo
        .customerSignOut(pref.getString("successToken"))
        .then((response) {
      final result = ShopLogoutResModel.fromJson(
        jsonDecode(response.body),
      );
      if (response.statusCode == 200) {
        print("result.message");
        final read=Provider.of<MainScreenController>(context,listen: false);
        read.onSignOut();

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OnBoardingScreenView()),
        );


        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
        pref.clear();

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

  List<bool> isFaqExpanded = [];
  Future<void> getCustomerFAQData(context) async {
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    customerFaqRepo
        .customerFaqData(pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result = CustomerFaqModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        customerfaqdataList = result.customerfaqdataList;
        print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
        print(customerfaqdataList);

        int length = customerfaqdataList?.length ?? 0;

        isFaqExpanded = List.filled(length, false, growable: true);

        isFaqExpanded.removeAt(0);
        isFaqExpanded.insert(0, true);

        showLoader(false);

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

  void onChangeExpansion(value, index) {
    isFaqExpanded =
        List.filled(customerfaqdataList?.length ?? 0, false, growable: true);
    isFaqExpanded[index] = value;

    notifyListeners();
  }
}
