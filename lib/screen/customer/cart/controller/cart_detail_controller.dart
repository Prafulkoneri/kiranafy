import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/cart/model/cart_detail_delete_model.dart';
import 'package:local_supper_market/screen/customer/cart/model/cart_detail_model.dart';
import 'package:local_supper_market/screen/customer/cart/model/cart_item_quantity_model.dart';
import 'package:local_supper_market/screen/customer/cart/model/cart_list_model.dart';
import 'package:local_supper_market/screen/customer/cart/repository/cart_detail_delete_repo.dart';
import 'package:local_supper_market/screen/customer/cart/repository/cart_detail_repo.dart';
import 'package:local_supper_market/screen/customer/cart/repository/cart_item_quantity_repo.dart';
import 'package:local_supper_market/screen/customer/cart/repository/cart_list_repo.dart';
import 'package:local_supper_market/screen/customer/cart/view/cart_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/add_fav_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/remove_fav_shop_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/add_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/remove_fav_shop_repo.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shop_profile/model/customer_view_shop_model.dart';

class CartDetailController extends ChangeNotifier {
  ShopCartListRepo cartListRepo = ShopCartListRepo();
  List quantityList = [];
  AddFavShopRepo addFavShopRepo = AddFavShopRepo();
  CartDetailRepo cartDetailRepo = CartDetailRepo();
  CartDetailDeleteRepo cartDetailDeleteRepo = CartDetailDeleteRepo();
  RemoveFavShopRepo removeFavShopRepo = RemoveFavShopRepo();
  CartItemQuantityRepo cartItemQuantityRepo = CartItemQuantityRepo();
  String itemCount = "";
  String totalAmount = "";
  String totalSavedAmount = "";
  bool isQuanityBtnPressed = false;

  CartItemQuantityReqModel get cartItemQuantityRequestModel =>
      CartItemQuantityReqModel(
          cartItemId: cartItemId,
          quantityAction: quantityAction,
          productType: productType,
          shopId: shopId);
  CartDetailDeleteRequestModel get cartDetailDeleteReqModel =>
      CartDetailDeleteRequestModel(
        cartId: cartId,
      );
  CartDetailRequestModel get cartDetailReqModel => CartDetailRequestModel(
        cartId: cartId,
        shopId: shopId,
      );
  AddFavReqModel get addFavReqModel => AddFavReqModel(
        shopId: shopId.toString(),
      );
  RemoveFavReqModel get removeFavReqModel => RemoveFavReqModel(
        shopId: shopId.toString(),
      );
  List<CartList>? cartList;
  ShopDetails? shopDetailData;
  List<CartItemList>? cartItemList;
  CartDetailData? cartDetailData;
  String shopId = "";
  String cartId = "";
  String cartItemId = "";
  String quantityAction = "";
  String productType = "";
  String orderCartId = "";
  bool isLoading = true;
  bool favAllShop = true;

  Future<void> initState(context, cId, id, isRefresh) async {
    if (isRefresh) {
      await getCartDetails(context, id, cId);
    }
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  quantityBtnPressed(value) {
    isQuanityBtnPressed = value;
    notifyListeners();
  }

  Future<void> getCartDetails(context, id, cId) async {
    showLoader(true);
    // print(object)
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
        itemCount = result.cartDetailData?.itemCount.toString() ?? "";
        totalAmount = result.cartDetailData?.totalAmount.toString() ?? "";
        totalSavedAmount =
            result.cartDetailData?.totalSavedAmount.toString() ?? "";
        orderCartId = result.cartDetailData?.cartId.toString() ?? "";
        int length = cartItemList?.length ?? 0;
        quantityList.clear();
        for (int i = 0; i < length; i++) {
          quantityList.add(cartItemList?[i].quantity);
        }
        favAllShop = shopDetailData?.shopFavourite == "yes" ? true : false;
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

  /////////////Delete Cart Detail////////////////
  Future<void> deleteCartDetails(context, cId) async {
    cartId = cId.toString();

    SharedPreferences pref = await SharedPreferences.getInstance();

    cartDetailDeleteRepo
        .cartDetailDelete(
            cartDetailDeleteReqModel, pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result =
          CartDetailDeleteResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if (result.status == 200) {
          print("helloooo");
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MainScreenView(index: 2, screenName: CartScreenView())),
            (Route<dynamic> route) => false,
          );
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.success);
        } else {
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
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

  Future<void> removeAllShopFavList(context, id) async {
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

  Future<void> updateAllShopFavList(context, id) async {
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

  Future<void> addItemQuantity(context, CIId, action, pType, index) async {
    quantityBtnPressed(true);
    cartItemId = CIId.toString();
    quantityAction = action;
    productType = pType;
    SharedPreferences pref = await SharedPreferences.getInstance();
    cartItemQuantityRepo
        .cartItemQuantity(
            cartItemQuantityRequestModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result =
          CartItemQuantityResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        int value = quantityList[index];
        quantityList.removeAt(index);
        quantityList.insert(index, value + 1);
        itemCount = result.itemQuantityData?.itemCount ?? "";
        totalAmount = result.itemQuantityData?.totalAmount.toString() ?? "";
        totalSavedAmount =
            result.itemQuantityData?.totalSavedAmount.toString() ?? "";
        quantityBtnPressed(false);
        notifyListeners();
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
        quantityBtnPressed(false);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
      quantityBtnPressed(false);
    }).catchError(
      (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        quantityBtnPressed(false);
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }

  Future<void> subtractItemQuantity(context, CIId, action, index) async {
    quantityBtnPressed(true);
    print("*********");
    print(quantityList);
    print(quantityList[index]);
    print("*********");
    cartItemId = CIId.toString();
    quantityAction = action;
    SharedPreferences pref = await SharedPreferences.getInstance();
    cartItemQuantityRepo
        .cartItemQuantity(
            cartItemQuantityRequestModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result =
          CartItemQuantityResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        int value = quantityList[index];
        quantityList.removeAt(index);
        print("${value}valueeeeeeeee");
        quantityList.insert(index, value - 1);
        itemCount = result.itemQuantityData?.itemCount ?? "";
        totalAmount = result.itemQuantityData?.totalAmount.toString() ?? "";
        totalSavedAmount =
            result.itemQuantityData?.totalSavedAmount.toString() ?? "";
        if (quantityList[index] == 0) {
          quantityList.removeAt(index);
          cartItemList?.removeAt(index);
        }
        if (cartItemList!.isEmpty) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MainScreenView(index: 2, screenName: CartScreenView())),
            (Route<dynamic> route) => false,
          );
        }
        quantityBtnPressed(false);
        notifyListeners();
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
        quantityBtnPressed(false);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
      quantityBtnPressed(false);
    }).catchError(
      (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        quantityBtnPressed(false);
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }
}
