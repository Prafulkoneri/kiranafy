import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:local_supper_market/screen/customer/cart/model/add_product_to_cart_model.dart';
import 'package:local_supper_market/screen/customer/cart/repository/add_product_to_cart_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/add_fav_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/remove_fav_shop_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/add_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/remove_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/remove_item_cart_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/view_all_offer_products_model.dart';

import 'package:local_supper_market/screen/customer/shop_profile/repository/all_products_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/repository/customer_view_shop_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/repository/remove_item_from_cart_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AllOffersController extends ChangeNotifier {
  String shopId = "";
  int offset = 0;
  bool isLoading = true;
  Data? allproducts;
  AllOfferProductsRepo allOfferProductsRepo = AllOfferProductsRepo();
  AddProductToCartRepo addProductToCartRepo = AddProductToCartRepo();
  List<ShopCategory>? shopCategory;
  List<CustomerProductData>? offerProduct;
  List<CustomerProductData> allOfferProducts = [];
  bool showPaginationLoader = false;
  List<bool> isAllOfferProductAdded = [];
  bool favAllShop = true; /////shop add fvrt
  AddFavShopRepo addFavShopRepo = AddFavShopRepo();
  RemoveCartItemRepo removeCartItemRepo = RemoveCartItemRepo();
  Future<void> initState(context, id) async {
    allOfferProducts.clear();
    offset = 0;
    await getAllOfferes(context, id);
    notifyListeners();
  }

  void showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  //////All Offer Products
  AllProductsReqModel get shopAllProductsReqModel => AllProductsReqModel(
      offset: offset.toString(), limit: "10", shopId: shopId);

  Future<void> getAllOfferes(context, id) async {
    if (offset == 0) {
      isLoading = true;
    }
    showPaginationLoader = true;
    shopId = id;
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    allOfferProductsRepo
        .getAllOffereProducts(
            shopAllProductsReqModel, pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result = ViewAllOfferProducts.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        // allOfferProducts.clear();
        allproducts = result.data;
        // allOfferProducts = allproducts?.offerProducts;
        allOfferProducts.addAll(result.data?.offerProducts ?? []);
        // int seasonProductLength = seasonalProduct?.length ?? 0;
        isAllOfferProductAdded =
            List<bool>.filled(allOfferProducts.length, false, growable: true);
        for (int i = 0; i < allOfferProducts.length; i++) {
          if (allOfferProducts[i].addToCartCheck == "yes") {
            isAllOfferProductAdded.insert(i, true);
          } else {
            isAllOfferProductAdded.insert(i, false);
          }
        }
        //   int seasonProductLength = seasonalProduct?.length ?? 0;
        // isAllSeasonalProductAdded =
        //     List<bool>.filled(seasonProductLength, false, growable: true);
        // for (int i = 0; i < seasonProductLength; i++) {
        //   if (seasonalProduct?[i].addToCartCheck == "yes") {
        //     isAllSeasonalProductAdded.insert(i, true);
        //   } else {
        //     isAllSeasonalProductAdded.insert(i, false);
        //   }
        // }
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

  void onOfferProductSelected(index) {
    isAllOfferProductAdded[index] = true;
    notifyListeners();
  }
  //////////////////

///////////////////Update List
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
        isAllOfferProductAdded[index] = true;
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

  Future<void> onScrollMaxExtent(context, id) async {
    print("hello");
    offset = offset + 1;
    await getAllOfferes(context, id);
    isLoading = false;

    notifyListeners();
  }

  ////////////////////////////////////////////////////////
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
        isAllOfferProductAdded[index] = false;
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
