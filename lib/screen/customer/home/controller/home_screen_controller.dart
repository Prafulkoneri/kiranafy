import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_supper_market/screen/customer/home/model/banner_model.dart';
import 'package:local_supper_market/screen/customer/home/model/category_model.dart';
import 'package:local_supper_market/screen/customer/home/model/place_add_banner_model.dart';
import 'package:local_supper_market/screen/customer/home/repository/banner_repo.dart';
import 'package:local_supper_market/screen/customer/home/repository/category_repo.dart';
import 'package:local_supper_market/screen/customer/home/repository/place_add_banner_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/all_near_shops_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/shop_as_per_pincode_all_near_shops.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreenController extends ChangeNotifier {
  BannerRepo bannerRepo = BannerRepo();
  PlaceAdRepo placeAdRepo = PlaceAdRepo();
  bool isLoading = true;
  AllCategoriesRepo allCategoriesRepo = AllCategoriesRepo();
  List<Data>? bannerData;
  PageController pageController =
      PageController(viewportFraction: 0.9, initialPage: 0);
  List<CategoriesList> categoryFirstList = [];
  List<CategoriesList> categorySecondList = [];
  int _currentPage = 0;
  AllNearShopRepo allNearShopRepo = AllNearShopRepo();
  List<AllNearShops>? nearByShopList;
  List<HomeScreenCouponData>? couponData;
  List<HomeScreenHelloOfferData>? hellotoffersdata;

  CPlaceAd? cplacead;
  List<CustomerPlaceAd>? customerplacead;
  List placeAd = [];
  // String pincode = "111111";
  String? productId = "";
  Future<void> initState(
    context,
    refresh,
  ) async {
    // Utils().CheckUserConnection(context, initState(context, true));
    if (refresh) {
      placeAd.clear();
      final a = await getBannerImage(context);
      print("HELLO1");
      final b = await getCategoryList(context);
      print("HELLO2");
      final c = await getAllNearByShops(context);
      print("HELLO3");
      final d = await getPlaceAd(context);
    } else {
      showLoader(false);
    }
    notifyListeners();
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

////////////////////////////////////////////////////////////////

///////////////////////////////Up///////////////////////////////////
  Future<void> getBannerImage(context) async {
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("sdbbbghnjnjnjnjnjnjnjnjnjnjnjnjnjnjnjnj");
    print(pref.getString("successToken"));
    bannerRepo.getBannerImage(pref.getString("successToken")).then((response) {
      print("777777777777777777777777777777");
      print(response.statusCode);
      print(response.body);
      print("777777777777777777777777777777");
      final result = BannerAds.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        log("ggggggggggggggggggggggggggggggggggg${response.body}");

        bannerData = result.data;
        int imageLength = bannerData?.length ?? 0;
        if (bannerData!.isNotEmpty) {
          Timer.periodic(Duration(seconds: 8), (Timer timer) {
            if (_currentPage < imageLength - 1) {
              _currentPage + 1;
            } else {
              _currentPage = 0;
            }
            // pageController.animateToPage(
            //   _currentPage,
            //   duration: Duration(milliseconds: 350),
            //   curve: Curves.easeIn,
            // );
          });
        }
        notifyListeners();
      } else if (response.statusCode == 401) {
        Utils().logoutUser(context);
      } else {
        showLoader(false);
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      showLoader(false);
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
      (Object e) {
        showLoader(false);
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e) {
        showLoader(false);
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

        notifyListeners();
      } else {
        showLoader(false);
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      showLoader(false);
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
      (Object e) {
        showLoader(false);
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e) {
        showLoader(false);
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }

  Future<void> getAllNearByShops(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    print(pref.getString("pincode"));
    // if(pref.getString("pincode")==null){
    //   pincode="111111";
    // }
    // else{
    //   pincode=pref.getString("pincode").toString();
    // }
    allNearShopRepo
        .getAllNearShop(pref.getString("successToken"))
        .then((response) {
      print("Shop List");
      log("Shop_list${response.body}");
      final result = AllNearShopsResModel.fromJson(jsonDecode(response.body));
      log(response.body);
      if (response.statusCode == 200) {
        nearByShopList = result.data;
        couponData = result.couponData;
        hellotoffersdata = result.hellotoffersdata;
        // showLoader(false);
        notifyListeners();
      } else {
        showLoader(false);
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      showLoader(false);
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
      (Object e) {
        showLoader(false);
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e) {
        showLoader(false);
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }

  //////////////////////////////////////
  Future<void> getPlaceAd(context) async {
    customerplacead?.clear();
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("bnvuuiwveuciiutwmibijmiuey");
    print(pref.getString("successToken"));
    placeAdRepo.placeAd(pref.getString("successToken")).then((response) {
      print(response.statusCode);
      log("bottommmmmmmmmmmmmmmmmmmmmmmm${response.body}");
      final result = PlaceAdBannerModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        log("placed ad${response.body}");
        cplacead = result.cplacead;
        customerplacead = cplacead?.customerplacead;
        int imageLength = customerplacead?.length ?? 0;
        // for (int i = 0; i < imageLength; i++) {
        //   placeAd.add(customerplacead?[i].shopBannerImagePath);
        // }

        showLoader(false);
        notifyListeners();
      } else {
        showLoader(false);
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      showLoader(false);
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
      (Object e) {
        showLoader(false);
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e) {
        showLoader(false);
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }

  bool isOfferCopied = false;

  void onDismiss() {
    isOfferCopied = false;
    notifyListeners();
  }

  ///////////////
  copyCode(context, offer) {
    isOfferCopied = true;
    notifyListeners();
    Clipboard.setData(ClipboardData(text: offer)).then((_) {
      // Utils.showPrimarySnackbar(context, "coupon code copid",
      //     type: SnackType.success);
    });
    Timer(Duration(seconds: 3), () async {
      isOfferCopied = false;
      notifyListeners();
    });
  }

  copyCodeForCoupanList(context, offerMsg) {
    Clipboard.setData(ClipboardData(text: offerMsg)).then((_) {
      Utils.showPrimarySnackbar(context, "Coupon Code Copied",
          type: SnackType.success);
    });
  }
}
