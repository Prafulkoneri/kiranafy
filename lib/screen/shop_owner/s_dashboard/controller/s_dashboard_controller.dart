import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_category_list/view/s_category_list_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/model/dash_board_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/repository/dashboard_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/model/shop_edit_profile_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/repository/shop_edit_profile_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/view/s_edit_profile_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_selected_products_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/view/s_select_category_view.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SDashBoardController extends ChangeNotifier {
  DashBoardRepo dashBoardRepo = DashBoardRepo();
  ShopEditProfileRepo shopEditProfileRepo = ShopEditProfileRepo();
  List<ShopBannerImageData>? bannerImageList;
  Data? dashBoardData;
  String address = "";
  String pincode = "";
  String shopName = "";
  int categoriesCount = 2;
  void onCategorySelect(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SSCategoryListView()));
  }

  void onEditBtnClicked(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SEditProfileView()));
  }

  Future<void> initState(context) async {
    await getDashBoardData(context);
    await getShopEditProfileDetails(context);
    notifyListeners();
  }

///////Category Count End
  Future<void> getDashBoardData(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    print(pref.getString("successToken"));
    dashBoardRepo
        .getDashboardData(pref.getString("successToken"))
        .then((response) {
      print(response.statusCode);
      print(response.body);
      final result = DashBoardModel.fromJson(jsonDecode(response.body));
      print("${response.body}");
      if (response.statusCode == 200) {
        dashBoardData = result.data;
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
