import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:local_supper_market/screen/customer/cart/model/add_product_to_cart_model.dart';
import 'package:local_supper_market/screen/customer/cart/repository/add_product_to_cart_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/recommanded_products_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/remove_item_cart_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/repository/recommanded_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/repository/remove_item_from_cart_repo.dart';

import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SAllRecommandedProductsController extends ChangeNotifier {
  String shopId = "";
  int offset = 0;
  bool isLoading = true;
  // bool? showPaginationLoader = true;
  bool showPaginationLoader = false;
  AddProductToCartRepo addProductToCartRepo = AddProductToCartRepo();
  List<bool> isRecommandedProductAdded = [];
  Data? data;
  // List<CustomerProductData>? recommandedProducts;
  List<CustomerProductData> recommandedProducts = [];
  Future<void> initState(context, id) async {
    recommandedProducts.clear();
    offset = 0;
    await getAllRecommandedProducts(context, id);
    notifyListeners();
  }

  void showLoader(value) {
    isLoading = value;
    notifyListeners();
  }
  //////All Offer Products////////

  ///////////////Seasonal Products/////////
  RecommandedReqModel get shopAllRecomandedReqModel => RecommandedReqModel(
      offset: offset.toString(), limit: "10", shopId: shopId);
  AllRecomandedRepo allRecommandedProductsRepo = AllRecomandedRepo();

  Future<void> getAllRecommandedProducts(context, id) async {
    if (offset == 0) {
      isLoading = true;
    }
    showPaginationLoader = true;
    showLoader(true);
    shopId = id; //store id
    SharedPreferences pref = await SharedPreferences.getInstance();
    allRecommandedProductsRepo
        .getAllRecommandedRepo(
            shopAllRecomandedReqModel, pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result = RecommandedResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        data = result.data;
        recommandedProducts.clear();
        // recommandedProducts = data?.recommandedProducts;
        recommandedProducts.addAll(result.data?.recommandedProducts ?? []);
        int recommandedProductLength = recommandedProducts?.length ?? 0;
        isRecommandedProductAdded =
            List<bool>.filled(recommandedProductLength, false, growable: true);
        for (int i = 0; i < recommandedProductLength; i++) {
          if (recommandedProducts?[i].addToCartCheck == "yes") {
            isRecommandedProductAdded.insert(i, true);
          } else {
            isRecommandedProductAdded.insert(i, false);
          }
        }
        showLoader(false);

        showPaginationLoader = false;
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

  void onRecommandedSelected(index) {
    isRecommandedProductAdded[index] = true;
    notifyListeners();
  }

  Future<void> addToCart(pType, pId, sId, index, context) async {
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
        isRecommandedProductAdded[index] = true;
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

  //////////
  Future<void> onScrollMaxExtent(context, id) async {
    print("hello");
    offset = offset + 1;
    showPaginationLoader = true;
    showLoader(true);
    shopId = id; //store id
    SharedPreferences pref = await SharedPreferences.getInstance();
    allRecommandedProductsRepo
        .getAllRecommandedRepo(
            shopAllRecomandedReqModel, pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result = RecommandedResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        data = result.data;
        // recommandedProducts.clear();
        // recommandedProducts = data?.recommandedProducts;
        recommandedProducts.addAll(result.data?.recommandedProducts ?? []);
        int recommandedProductLength = recommandedProducts?.length ?? 0;
        isRecommandedProductAdded =
            List<bool>.filled(recommandedProductLength, false, growable: true);
        for (int i = 0; i < recommandedProductLength; i++) {
          if (recommandedProducts?[i].addToCartCheck == "yes") {
            isRecommandedProductAdded.insert(i, true);
          } else {
            isRecommandedProductAdded.insert(i, false);
          }
        }
        showLoader(false);

        showPaginationLoader = false;
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
    // await getAllRecommandedProducts(context, id);
    isLoading = false;

    notifyListeners();
  }

//////////////////////////////////////////////////////////////
  RemoveCartItemRepo removeCartItemRepo = RemoveCartItemRepo();
  Future<void> removeFromCart(pType, puId, sId, index, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    removeCartItemRepo
        .removeCartItem(
            RemoveItemFromCartReq(
                productType: pType.toString(),
                productUnitId: puId.toString(),
                shopId: sId.toString(),
                quantity: "0"),
            pref.getString("successToken"))
        .then((response) async {
      log("response.body${response.body}");
      final result =
          CartRemoveResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        isRecommandedProductAdded[index] = false;
        // await getAllOfferes(context, sId);
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
