import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';

// import 'package:local_supper_market/screen/customer/shop_profile/model/view_all_offer_products.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/view_all_seasonal_products.dart';

import 'package:local_supper_market/screen/customer/shop_profile/repository/all_seasonal_repo.dart';

import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopAllSeasonalController extends ChangeNotifier {
  String shopId = "";
  int offset = 0;
  bool? isLoading = true;
  bool? showPaginationLoader = true;

  Data? data;
  List<SeasonalProduct>? seasonalProduct;
  Future<void> initState(context, id) async {
    // await getShopDetails(context, id);
    await getAllSeasonalProducts(context, id);
    notifyListeners();
  }

  //////All Offer Products

  ///////////////Seasonal Products/////////
  AllSeasonalProductsReqModel get shopAllSeasonalReqModel =>
      AllSeasonalProductsReqModel(
          offset: offset.toString(), limit: "10", shopId: shopId);
  AllSeasonalProductsRepo allSeasonalProductsRepo = AllSeasonalProductsRepo();

  Future<void> getAllSeasonalProducts(context, shopId) async {
    isLoading = true;

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
        seasonalProduct = data?.seasonalProducts;
        isLoading = false;
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
}
