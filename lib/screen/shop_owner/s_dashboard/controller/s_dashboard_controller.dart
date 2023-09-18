import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/controller/s_account_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_category_list/view/s_category_list_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/model/dash_board_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/repository/dashboard_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/model/shop_edit_profile_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/repository/shop_edit_profile_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_my_subscription/model/get_subscription_history_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_my_subscription/repository/get_subscription_history_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SDashBoardController extends ChangeNotifier {
  DashBoardRepo dashBoardRepo = DashBoardRepo();
  ShopEditProfileRepo shopEditProfileRepo = ShopEditProfileRepo();
  SAccountScreenController sAccountScreenController =
      SAccountScreenController();
  List<ShopBannerImageData>? bannerImageList;
  bool isLoading = true;
  Data? dashBoardData;
  String address = "";
  String pincode = "";
  String shopName = "";
  // int categoriesCount = 2;
  int _currentPage = 0;
  PageController pageController = PageController();
  SubcriptionData? subscriptiondata;
  CurrentSubscriptionPlan? currentSubscriptionPlan;
  List<SubscriptionHistory>? subscriptionHistory;
  List specialBenifitlist = [];

  // void onCategorySelect(context) {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => SSCategoryListView()));
  // }

  // void onEditBtnClicked(context) {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => SEditProfileView()));
  // }

  Future<void> initState(context, refresh) async {
    if (refresh) {
      await getDashBoardData(context);
      await getShopEditProfileDetails(context);
      await getSubscriptionPaymentHistory(context);
    }
    notifyListeners();
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

///////Category Count End
  Future<void> getDashBoardData(context) async {
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();

    print(pref.getString("successToken"));
    dashBoardRepo
        .getDashboardData(pref.getString("successToken"))
        .then((response) {
      print(response.statusCode);
      log(response.body);
      final result = DashBoardModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        dashBoardData = result.data;
        int imageLength = dashBoardData?.bannerImages?.length ?? 0;
        if (dashBoardData?.bannerImages!.isNotEmpty ?? true) {
          Timer.periodic(Duration(seconds: 5), (Timer timer) {
            if (_currentPage < imageLength - 1) {
              _currentPage++;
            } else {
              _currentPage = 0;
            }
            pageController.animateToPage(
              _currentPage,
              duration: Duration(milliseconds: 450),
              curve: Curves.easeIn,
            );
          });
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

  //////////////////Category Count End

  /////////////Display Name IN Dash Board
  Future<void> getShopEditProfileDetails(context) async {
    print("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    shopEditProfileRepo
        .getShopEditProfileDetails(pref.getString("successToken"))
        .then((response) {
      final result = AccountDetailsResModel.fromJson(
        jsonDecode(response.body),
      );
      if (response.statusCode == 200) {
        final shopDetails = result.shopDetails;
        print(shopDetails);
        log("${response.body}");

        address = shopDetails?.shopAddress ?? "";
        pincode = shopDetails?.shopPincode.toString() ?? "";
        shopName = shopDetails?.shopName ?? "";
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

  /////////////////////////////////SubScription in Dash BOard/////////////////////
  SubscriptionHistoryRepo subscriptionHistoryRepo = SubscriptionHistoryRepo();
  Future<void> getSubscriptionPaymentHistory(context) async {
    showLoader(true);
    print("loading");
    SharedPreferences pref = await SharedPreferences.getInstance();
    subscriptionHistoryRepo
        .subscriptionHistory(pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result =
          GetSubscriptionHistoryModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        subscriptiondata = result.subscriptiondata;
        currentSubscriptionPlan = subscriptiondata?.currentSubscriptionPlan;
        subscriptionHistory = subscriptiondata?.subscriptionHistory;
        specialBenifitlist.clear();
        specialBenifitlist =
            currentSubscriptionPlan?.subscriptionSpecialBenifits ?? [];
        print("77777777");
        print(specialBenifitlist);
        print(specialBenifitlist.contains("create_offer_coupons"));
        // print(specialBenifitlist[1]);
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
}
