import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/favourites/model/all_fvrt_shops.dart';
import 'package:local_supper_market/screen/customer/favourites/repository/all_shop_fvrt_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/add_fav_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/remove_fav_shop_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/add_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/remove_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/shop_as_per_pincode_all_near_shops.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritesController extends ChangeNotifier {
  AllFvrtShopsRepo allFvrtShopsRepo = AllFvrtShopsRepo();
  AddFavShopRepo addFavShopRepo = AddFavShopRepo();
  bool isFavShopPressed = true;
  List<FavouriteData>? favShopList;
  bool isLoading = true;
  String shopId = "";
  RemoveFavShopRepo removeFavShopRepo = RemoveFavShopRepo();
  List<bool> fav = [];
  Future<void> initState(context) async {
    favShopList?.clear();
    isLoading = true;
    await getAllFavouriteShop(context);
  }

  onFavouriteShopTapped() {
    isFavShopPressed = true;
    notifyListeners();
  }

  onFavouriteProductTapped() {
    isFavShopPressed = false;
    notifyListeners();
  }

  Future<void> getAllFavouriteShop(context) async {
    isLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    allFvrtShopsRepo
        .allfvrtShops(pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result = GetAllFavShopsResModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        favShopList = result.data;
        fav = List<bool>.filled(favShopList?.length ?? 0, true, growable: true);
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

  AddFavReqModel get addFavReqModel => AddFavReqModel(
        shopId: shopId.toString(),
      );

  Future<void> updateFavList(context, id, index) async {
    shopId = id.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    addFavShopRepo
        .updateAddFavShop(addFavReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = AddFavResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        fav[index] = true;
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

  RemoveFavReqModel get removeFavReqModel => RemoveFavReqModel(
        shopId: shopId.toString(),
      );

  Future<void> removeFavList(context, id, index) async {
    shopId = id.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    removeFavShopRepo
        .updateRemoveFavShop(removeFavReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = RemoveFavResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        fav[index] = false;
        favShopList?.removeAt(index);
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
}
