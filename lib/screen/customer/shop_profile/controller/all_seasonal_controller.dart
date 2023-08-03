import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:local_supper_market/screen/customer/cart/model/add_product_to_cart_model.dart';
import 'package:local_supper_market/screen/customer/cart/repository/add_product_to_cart_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';

// import 'package:local_supper_market/screen/customer/shop_profile/model/view_all_offer_products.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/view_all_seasonal_products_model.dart';

import 'package:local_supper_market/screen/customer/shop_profile/repository/all_seasonal_repo.dart';

import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopAllSeasonalController extends ChangeNotifier {
  String shopId = "";
  int offset = 0;
  bool isLoading = true;
  bool showPaginationLoader = false;
  AddProductToCartRepo addProductToCartRepo = AddProductToCartRepo();
  Data? data;
  // List<CustomerProductData>? seasonalProduct;
  List<CustomerProductData> seasonalProduct = [];
  Future<void> initState(context, id) async {
    seasonalProduct.clear();
    offset=0;
    // await getShopDetails(context, id);
    await getAllSeasonalProducts(context, id);
    notifyListeners();
  }

  void showLoader(value) {
    isLoading = value;
    notifyListeners();
  }
  //////All Offer Products

  ///////////////Seasonal Products/////////
  AllSeasonalProductsReqModel get shopAllSeasonalReqModel =>
      AllSeasonalProductsReqModel(
          offset: offset.toString(), limit: "10", shopId: shopId);
  AllSeasonalProductsRepo allSeasonalProductsRepo = AllSeasonalProductsRepo();

  Future<void> getAllSeasonalProducts(context, id) async {
    if(offset==0){
      isLoading = true;
    }
    showPaginationLoader = true;
    showLoader(true);
    shopId = id;

    SharedPreferences pref = await SharedPreferences.getInstance();
    allSeasonalProductsRepo
        .getAllSeasonalProducts(
            shopAllSeasonalReqModel, pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result =
          ViewAllSeasonalProducts.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        data = result.data;
        // seasonalProduct = data?.seasonalProducts;
        seasonalProduct.addAll(result.data?.seasonalProducts ?? []);
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
  Future<void> onScrollMaxExtent(context,id) async {

    print("hello");
    offset = offset + 1;
    await getAllSeasonalProducts(context,id);
    isLoading = false;

    notifyListeners();
  }
}
