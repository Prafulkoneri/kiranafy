import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:local_supper_market/screen/customer/cart/model/add_product_to_cart_model.dart';
import 'package:local_supper_market/screen/customer/cart/repository/add_product_to_cart_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/recommanded_products_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/repository/recommanded_repo.dart';

import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SAllRecommandedProductsController extends ChangeNotifier {
  String shopId = "";
  int offset = 0;
  bool isLoading = true;
  bool? showPaginationLoader = true;
  AddProductToCartRepo addProductToCartRepo=AddProductToCartRepo();

  Data? data;
  List<CustomerProductData>? recommandedProducts;
  Future<void> initState(context, id) async {
    await getAllRecommandedProducts(context, id);
    notifyListeners();
  }
  void showLoader(value){
    isLoading=value;
    notifyListeners();
  }
  //////All Offer Products////////

  ///////////////Seasonal Products/////////
  RecommandedReqModel get shopAllRecomandedReqModel => RecommandedReqModel(
      offset: offset.toString(), limit: "10", shopId: shopId);
  AllRecomandedRepo allRecommandedProductsRepo = AllRecomandedRepo();

  Future<void> getAllRecommandedProducts(context, id) async {
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
        recommandedProducts = data?.recommandedProducts;
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
  Future<void> addToCart(pType,pId,sId,context)async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    addProductToCartRepo
        .addProductToCart(AddProductToCartReqModel(productType:pType,productUnitId: pId.toString(),shopId: sId.toString(),quantity:"1"),pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = AddProductToCartResModel.fromJson(jsonDecode(response.body));
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
}
