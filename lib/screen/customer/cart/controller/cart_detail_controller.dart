import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/main.dart';
import 'package:local_supper_market/screen/customer/auth/model/customer_sign_in_model.dart';
import 'package:local_supper_market/screen/customer/auth/model/mobile_number_check_model.dart';
import 'package:local_supper_market/screen/customer/auth/repository/customer_sign_in_repo.dart';
import 'package:local_supper_market/screen/customer/auth/repository/mobile_number_check_repo.dart';
import 'package:local_supper_market/screen/customer/auth/view/customer_sign_in_view.dart';
import 'package:local_supper_market/screen/customer/auth/view/customer_sign_up_view.dart';
import 'package:local_supper_market/screen/customer/cart/model/cart_detail_model.dart';
import 'package:local_supper_market/screen/customer/cart/model/cart_list_model.dart';
import 'package:local_supper_market/screen/customer/cart/repository/cart_detail_repo.dart';
import 'package:local_supper_market/screen/customer/cart/repository/cart_list_repo.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shop_profile/model/customer_view_shop_model.dart';

class CartDetailController extends ChangeNotifier {
  ShopCartListRepo cartListRepo = ShopCartListRepo();
  CartDetailRepo cartDetailRepo = CartDetailRepo();
  CartDetailRequestModel get cartDetailReqModel => CartDetailRequestModel(
        cartId: cartId,
        shopId: shopId,
      );
  List<CartList>? cartList;
  ShopDetails? shopDetailData;
  List<CartItemList>? cartItemList;
  String shopId = "";
  String cartId = "";

  Future<void> initState(context, cId, id) async {
    await getCartDetails(context, id, cId);
  }

  Future<void> getCartDetails(context, id, cId) async {
    shopId = id.toString();
    cartId = cId.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    cartDetailRepo
        .cartDetailView(cartDetailReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result =
          CartDetailResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        shopDetailData = result.cartDetailData?.shopDetails;
        cartItemList = result.cartDetailData?.cartItemList;
        print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhsssssssssssssssssssssss");
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
