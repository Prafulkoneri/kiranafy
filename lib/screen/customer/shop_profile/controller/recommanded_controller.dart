import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:local_supper_market/screen/customer/cart/model/add_product_to_cart_model.dart';
import 'package:local_supper_market/screen/customer/cart/model/cart_item_quantity_model.dart';
import 'package:local_supper_market/screen/customer/cart/repository/add_product_to_cart_repo.dart';
import 'package:local_supper_market/screen/customer/cart/repository/cart_item_quantity_repo.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/recommanded_products_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/remove_item_cart_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/repository/recommanded_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/repository/remove_item_from_cart_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SAllRecommandedProductsController extends ChangeNotifier {
  String shopId = "";
  int offset = 0;
  bool isLoading = true;
  // bool? showPaginationLoader = true;
  bool showPaginationLoader = false;
  AddProductToCartRepo addProductToCartRepo = AddProductToCartRepo();
  List<bool> isRecommandedProductAdded = [];
  Data? data;

  bool isQuanityBtnPressed = false;
  // List cartItemIdList = [];
  List cartItemIdList = [];
  List quantityList = [];
  String quantityAction = "";
  String cartItemId = "";
  String productType = "";
  CartItemQuantityRepo cartItemQuantityRepo = CartItemQuantityRepo();
  // List<CustomerProductData>? recommandedProducts;
  List<CustomerProductData> recommandedProducts = [];
  Future<void> initState(context, id) async {
    quantityList.clear();
    cartItemIdList.clear();
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
        /////////////////////
        for (int i = 0; i < recommandedProductLength; i++) {
          quantityList.add(recommandedProducts[i].quantity);
          cartItemIdList.add(recommandedProducts[i].cartItemId);
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

    if (pref.getString("status") == "guestLoggedIn") {
      Utils().showLoginDialog(context, "Please Login to add product to cart");
      return;
    }
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
        final readMain =
            Provider.of<MainScreenController>(context, listen: false);
        readMain.getCartCount(result.cartCount);
        isRecommandedProductAdded[index] = true;
        quantityList.removeAt(index);
        quantityList.insert(index, 1);
        print(quantityList);
        cartItemIdList.removeAt(index);
        cartItemIdList.insert(index, result.cartItemId);
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
        int length = result.data?.recommandedProducts?.length ?? 0;
        for (int i = 0; i < length; i++) {
          quantityList.add(result.data?.recommandedProducts?[i].quantity);
          cartItemIdList.add(result.data?.recommandedProducts?[i].cartItemId);
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
        final readMain =
            Provider.of<MainScreenController>(context, listen: false);
        readMain.getCartCount(result.cartCount);
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
////////////////////////////////////////////////////////////////

  quantityBtnPressed(value) {
    isQuanityBtnPressed = value;
    notifyListeners();
  }

  CartItemQuantityReqModel get cartItemQuantityRequestModel =>
      CartItemQuantityReqModel(
          cartItemId: cartItemId,
          quantityAction: quantityAction,
          productType: productType,
          shopId: shopId);

  Future<void> subtractItemQuantity(
      context, CIId, index, pType, pUnitId) async {
    quantityBtnPressed(true);
    print("*********");
    print(quantityList);
    print(quantityList[index]);
    print("*********");
    quantityAction = "subtract";
    productType = pType;
    print(cartItemIdList);
    cartItemId = cartItemIdList[index].toString();
    print(cartItemId);
    SharedPreferences pref = await SharedPreferences.getInstance();
    cartItemQuantityRepo
        .cartItemQuantity(
            cartItemQuantityRequestModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result =
          CartItemQuantityResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if (result.status == 200) {
          int value = quantityList[index];
          quantityList.removeAt(index);
          print("${value}valueeeeeeeee");
          quantityList.insert(index, value - 1);

          if (quantityList[index] == 0) {
            removeFromCart(pType, pUnitId, shopId, index, context);
          }
          quantityBtnPressed(false);
          notifyListeners();
        } else {
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
          quantityBtnPressed(false);
        }
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

  Future<void> addItemQuantity(context, CIId, pType, index) async {
    quantityBtnPressed(true);
    quantityAction = "add";
    cartItemId = cartItemIdList[index].toString();
    productType = pType;
    SharedPreferences pref = await SharedPreferences.getInstance();
    cartItemQuantityRepo
        .cartItemQuantity(
            cartItemQuantityRequestModel, pref.getString("successToken"))
        .then((response) {
      print("hello");
      log("response.body${response.body}");
      final result =
          CartItemQuantityResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if (result.status == 200) {
          int value = quantityList[index];
          quantityList.removeAt(index);
          quantityList.insert(index, value + 1);
          quantityBtnPressed(false);

          notifyListeners();
        } else {
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
          quantityBtnPressed(false);
        }
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
