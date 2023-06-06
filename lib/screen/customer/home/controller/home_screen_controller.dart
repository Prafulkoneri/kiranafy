import 'dart:async';
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
  List<Data>? bannerData;
  PageController pageController=PageController(viewportFraction: 0.9, initialPage: 1);
  List<CategoriesList> categoryFirstList = [];
  List<CategoriesList> categorySecondList = [];
  int _currentPage=0;
  // String pincode = "111111";
  Future<void> initState(context,refresh) async {
    if(refresh) {
      await getBannerImage(context);
      await getCategoryList(context);

    }else{
      showLoader(false);
    }
    notifyListeners();
  }

  showLoader(value){
    isLoading=value;
    notifyListeners();
  }

  Future<void> getBannerImage(context) async {
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("bnvuuiwveuciiutwmibijmiuey");
    print(pref.getString("successToken"));
    bannerRepo.getBannerImage(pref.getString("successToken")).then((response) {
      print(response.statusCode);
      print(response.body);
      final result = BannerAds.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        print("${response.body}");

        bannerData = result.data;
        int imageLength=bannerData?.length??0;
        if(bannerData!.isNotEmpty){
          Timer.periodic(Duration(seconds: 5), (Timer timer) {
            if (_currentPage < imageLength-1) {
              _currentPage++;
            } else {
              _currentPage = 0;
            }
            pageController.animateToPage(
              _currentPage,
              duration: Duration(milliseconds: 350),
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

  // AllCategoriesReqModel get allCategoriesReqModel =>
  //     AllCategoriesReqModel(pincode: pincode);

  Future<void> getCategoryList(context) async {

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
