import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/cart/model/add_product_to_cart_model.dart';
import 'package:local_supper_market/screen/customer/cart/repository/add_product_to_cart_repo.dart';
import 'package:local_supper_market/screen/customer/home/view/home_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/add_fav_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/remove_fav_shop_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/add_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/remove_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/view/all_near_shops_category_view.dart';
import 'package:local_supper_market/screen/customer/near_shops/view/all_near_shops_view.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/shop_coupons_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/view_all_offer_products_model.dart';

import 'package:local_supper_market/screen/customer/shop_profile/repository/all_products_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/repository/customer_view_shop_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/repository/shop_profile_coupons_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/model/dash_board_model.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopProfileViewController extends ChangeNotifier {
  String shopId = "";
  int offset = 0;
  bool isLoading = true;
  PageController pageController = PageController();
  // Data? allproducts;
  CustomerViewShopRepo customerViewShopRepo = CustomerViewShopRepo();
  AllOfferProductsRepo allOfferProductsRepo = AllOfferProductsRepo();
  ShopViewData? shopData;
  ShopDetails? shopDetails;
  List<ShopCategory>? shopCategory;
  List<CustomerProductData>? offerProduct;
  List<CustomerProductData>? allOfferProducts;
  List<CustomerProductData>? seasonalProduct;
  List<CustomerProductData>? recommandedProduct;
  List<BannerImageData>? bannerImageData;
  List<ShopCouponsList>? shopCouponsList;
  SProfileCouponData? sprofilecoupondata;
  int _currentPage = 0;
  bool ? deliveryAddressStatus;

  AddProductToCartRepo addProductToCartRepo = AddProductToCartRepo();
  ShopProfileCouponRepo sProfileCouponRepo = ShopProfileCouponRepo();
  bool favAllShop = true; /////shop add fvrt
  AddFavShopRepo addFavShopRepo = AddFavShopRepo();

  Future<void> initState(context, id, refresh) async {
    if (refresh) {
      await getShopDetails(context, id);
      await sProfileCouponList(context);
    } else {
      showLoader(false);
    }
  }

  void showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  CustomerViewShopReqModel get customerViewShopReqModel =>
      CustomerViewShopReqModel(
        shopId: shopId,
      );

  void onBackPressed(screenName, context, cId) {
    print(screenName);
    if (screenName == "allNearShopView") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => MainScreenView(
                index: 1,
                screenName: AllNearShopsView(
                  isSearchFocus: false,
                  refreshPage: false,
                ))),
        (Route<dynamic> route) => false,
      );
    }
    if (screenName == "nearShopsCategory") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => MainScreenView(
                index: 1,
                screenName: AllNearCategoryShopsView(
                  categoryId: cId,
                  refresh: false,
                ))),
        (Route<dynamic> route) => false,
      );
    }
    if (screenName == "homeNearbyShop") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => MainScreenView(
                index: 0,
                screenName: HomeScreenView(
                  refreshPage: false,
                ))),
        (Route<dynamic> route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => MainScreenView(
                index: 0, screenName: HomeScreenView(refreshPage: false))),
        (Route<dynamic> route) => false,
      );
    }
  }

  Future<void> getShopDetails(context, id) async {
    showLoader(true);
    print("id$id");
    shopId = id;
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    customerViewShopRepo
        .getShopDetails(
            customerViewShopReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result =
          CustomerViewShopResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        deliveryAddressStatus=result.deliveryAddressStatus;
        shopData = result.data;
        shopDetails = shopData?.shopDetails;
        shopCategory = shopData?.shopCategories;
        offerProduct = shopData?.offerProduct;
        seasonalProduct = shopData?.seasonalProduct;
        recommandedProduct = shopData?.recommandedProduct;
        bannerImageData = shopData?.bannerImages;

        favAllShop = shopDetails?.shopFavourite == "yes" ? true : false;
        print("bye");
        print(favAllShop);
        print("uivynuibnywetinyiqwn8wq7eyvnb8q8ew");
        showLoader(false);
        int imageLength = bannerImageData?.length ?? 0;
        if (bannerImageData!.isNotEmpty) {
          Timer.periodic(Duration(seconds: 5), (Timer timer) {
            if (_currentPage < imageLength - 1) {
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

  void launchPhone(String mobNumber, context) async {
    var number = Uri.parse("tel:${mobNumber}");
    if (await canLaunchUrl(number)) {
      await launchUrl(number);
    } else {
      Utils.showPrimarySnackbar(context, "Unable to dial at the moment",
          type: SnackType.error);
    }
  }

  //////All Offer Products
  AllProductsReqModel get shopAllProductsReqModel => AllProductsReqModel(
      offset: offset.toString(), limit: "10", shopId: shopId);

  RemoveFavReqModel get removeFavReqModel => RemoveFavReqModel(
        shopId: shopId.toString(),
      );
  RemoveFavShopRepo removeFavShopRepo = RemoveFavShopRepo();

  Future<void> removeAllShopFavList(context, id) async {
    shopId = id.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    removeFavShopRepo
        .updateRemoveFavShop(removeFavReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = RemoveFavResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        favAllShop = false;
        print("hello");
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
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

///////////////////Update List///
  AddFavReqModel get addFavReqModel => AddFavReqModel(
        shopId: shopId.toString(),
      );
  Future<void> updateAllShopFavList(context, id) async {
    shopId = id.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    addFavShopRepo
        .updateAddFavShop(addFavReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = AddFavResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        favAllShop = true;
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
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

  Future<void> addToCart(pType, pId, sId, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    addProductToCartRepo
        .addProductToCart(
            AddProductToCartReqModel(
                productType: pType,
                productUnitId: pId.toString(),
                shopId: sId.toString(),
                quantity: "1"),
            pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result =
          AddProductToCartResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
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

  ShopPCouponsReqModel get shopPCouponReqModel => ShopPCouponsReqModel(
        shopId: shopId.toString(),
      );
  Future<void> sProfileCouponList(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    print(pref.getString("pincode"));
    // if(pref.getString("pincode")==null){
    //   pincode="111111";
    // }
    // else{
    //   pincode=pref.getString("pincode").toString();
    // }
    sProfileCouponRepo
        .sProfileCouponRepo(shopPCouponReqModel, pref.getString("successToken"))
        .then((response) {
      print("Shop List");
      log("Shop_list${response.body}");
      final result = ShopPCouponsResModel.fromJson(jsonDecode(response.body));
      log(response.body);
      if (response.statusCode == 200) {
        sprofilecoupondata = result.sprofilecoupondata;
        shopCouponsList = sprofilecoupondata?.shopCouponsList;
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
