import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/on_boarding/view/on_boarding_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/model/shop_edit_profile_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/repository/shop_edit_profile_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/view/s_edit_profile_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/view/s_shop_configuration_view.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SAccountScreenController extends ChangeNotifier {
  String Validation = "";
  String email = "";
  String name = "";
  String number = "";
  String shopName = "";
  String shopOwnerName = "";
  String shopImage="";
  ShopEditProfileRepo shopEditProfileRepo = ShopEditProfileRepo();
  // void onEditBtnClicked(context) {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => SEditProfileView()));
  // }

  void onShopConfigurationClicked(context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SShopConfigurationView()));
  }

  Future<void> initState(context, updateMessage) async {
    print("999999999999");
    await getShopEditProfileDetails(context);
    notifyListeners();
  }

  void onLogout(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => OnBoardingScreenView()));
  }

  Future<void> getShopEditProfileDetails(context) async {
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

        number = shopDetails?.shopOwnerMobileNumber.toString() ?? "";
        email = shopDetails?.shopOwnerEmail ?? "";
        name = shopDetails?.shopName ?? "";
        shopName = shopDetails?.shopName ?? "";
        shopOwnerName=shopDetails?.shopOwnerName??"";
        if(result.shopBannerImages!.isNotEmpty) {
          shopImage = result.shopBannerImages?[0].shopBannerImagePath ?? "";
        }
        else{
          shopImage="";
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
