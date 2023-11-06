import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:local_supper_market/screen/customer/cart/model/cart_list_model.dart';
import 'package:local_supper_market/screen/customer/cart/model/shop_cart_delete_model.dart';
import 'package:local_supper_market/screen/customer/cart/repository/cart_list_repo.dart';
import 'package:local_supper_market/screen/customer/cart/repository/shop_cart_delete_repo.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartListController extends ChangeNotifier {
  ShopCartListRepo cartListRepo = ShopCartListRepo();
  ShopCartDeleteRepo shopCartDeleteRepo = ShopCartDeleteRepo();
  List<CartList>? cartList;
  bool isLoading = true;

  Future<void> initState(
    context,
  ) async {
    await getCartList(
      context,
    );
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getCartList(context) async {
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    cartListRepo.cartList(pref.getString("successToken")).then((response) {
      print(response.body);
      log(response.body);
      final result = CartListModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        cartList = result.cartData?.cartList;
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

//////////////////////////////Delete/////////////////////
  Future<void> deleteShopCart(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    shopCartDeleteRepo
        .deleteShopCart(pref.getString("successToken"))
        .then((response) {
      print(response.body);
      log(response.body);
      final result = ShopCartDeleteResModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        cartList?.clear();
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
