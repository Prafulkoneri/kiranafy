import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/home/model/banner_model.dart';
import 'package:local_supper_market/screen/customer/home/model/category_model.dart';
import 'package:local_supper_market/screen/customer/home/repository/banner_repo.dart';
import 'package:local_supper_market/screen/customer/home/repository/category_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenController extends ChangeNotifier {
  BannerRepo bannerRepo = BannerRepo();
  bool isLoading = true;
  AllCategoriesRepo allCategoriesRepo = AllCategoriesRepo();
  List<Data>? data;
  List<CategoriesList> categoryFirstList = [];
  List<CategoriesList> categorySecondList = [];
  // String pincode = "111111";
  Future<void> initState(context) async {
    isLoading = true;
    await getCategoryList(context);
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

  // AllCategoriesReqModel get allCategoriesReqModel =>
  //     AllCategoriesReqModel(pincode: pincode);

  Future<void> getCategoryList(context) async {
    isLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    // if (pref.getString("successToken") == null) {
    //   pincode = "111111";
    // } else {
    //   pincode = pref.getString("successToken").toString();
    // }
    allCategoriesRepo
        .getCategory(pref.getString("successToken"))
        .then((response) {
      print(response.statusCode);
      print(response.body);
      final result = AllCategoriesResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        print("${response.body}");
        print("77777777");

        print(result.categoriesFirstList);
        print("77777777");
        categoryFirstList = result.categoriesFirstList ?? [];
        categorySecondList = result.categoriesSecondList ?? [];
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
