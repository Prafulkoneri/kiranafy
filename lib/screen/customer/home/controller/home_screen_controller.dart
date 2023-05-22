import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/home/model/banner_model.dart';
import 'package:local_supper_market/screen/customer/home/repository/banner_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenController extends ChangeNotifier {
  BannerRepo bannerRepo = BannerRepo();
  List<Data>? data;
  Future<void> initState(context) async {
    await getBannerImage(context);
    notifyListeners();
  }

  Future<void> getBannerImage(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("bnvuuiwveuciiutwmibijmiuey");
    print(pref.getString("successToken"));
    bannerRepo.getBannerImage(pref.getString("successToken")).then((response) {
      print(response.statusCode);
      print(response.body);
      final result = BannerAds.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        print("${response.body}");

        data = result.data;
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
