import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:local_supper_market/screen/customer/near_shops/model/add_fav_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/all_near_shops_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/remove_fav_shop_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/add_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/remove_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/shop_as_per_pincode_all_near_shops.dart';

import 'package:local_supper_market/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllNearShopsAsPerPincode extends ChangeNotifier {
  AllNearShopRepo allNearShopRepo = AllNearShopRepo();
  AddFavShopRepo addFavShopRepo = AddFavShopRepo();
  RemoveFavShopRepo removeFavShopRepo = RemoveFavShopRepo();

  List<AllNearShops>? nearByShopList;
  List<bool> fav = [];
  List favList = [];
  String shopId = "";
  String pincode = "111111";

  Future<void> initState(context) async {
    await getAllNearByShops(context);
  }
  // AllNearShopsReqModel get allNearShopsReqModel=>AllNearShopsReqModel(pincode:pincode);

  Future<void> getAllNearByShops(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    print(pref.getString("pincode"));

    allNearShopRepo
        .getAllNearShop(pref.getString("successToken"))
        .then((response) {
      print("Shop List");
      print(response.body);
      final result = AllNearShopsResModel.fromJson(jsonDecode(response.body));
      print(response.body);
      if (response.statusCode == 200) {
        nearByShopList = result.data;

        fav = List<bool>.filled(nearByShopList?.length ?? 0, false,
            growable: true);

        int length = nearByShopList?.length ?? 0;
        for (int i = 0; i < length; i++) {
          if (nearByShopList?[i].isFavourite == "yes") {
            fav.insert(i, true);
            favList.add(nearByShopList?[i].id);
          }
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

  AddFavReqModel get addFavReqModel => AddFavReqModel(
        shopId: shopId.toString(),
      );

  Future<void> updateFavList(context, id, index) async {
    shopId = id.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
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
