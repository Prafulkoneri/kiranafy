import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:local_supper_market/screen/customer/products/model/product_view_model.dart';
import 'package:local_supper_market/screen/customer/products/repository/product_view_repo.dart';

// import 'package:local_supper_market/screen/customer/shop_profile/model/view_all_offer_products.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/view_all_seasonal_products.dart';

import 'package:local_supper_market/screen/customer/shop_profile/repository/all_seasonal_repo.dart';

import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductViewController extends ChangeNotifier {
  String? shopId = "";
  String? categoryId = "";
  String? productId = "";
  ProductViewData? productViewData;
  ProductDetails? productDetails;
  List<ProductUnitDetail>? productUnitDetail;
  List<SimilarProduct>? similarProduct;

  ProductViewRepo productViewRepo = ProductViewRepo();
  Future<void> initState(context, sId, cId, pId) async {
    productsView(context, sId, cId, pId);
    notifyListeners();
  }

  ProductViewRequestModel get productViewRequestModel =>
      ProductViewRequestModel(
          shopId: shopId, categoryId: categoryId, productId: productId);

  Future<void> productsView(context, sId, cId, pId) async {
    // print("id$id");
    shopId = sId;
    categoryId = cId;
    productId = pId;
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    productViewRepo
        .showProductsViewRepo(
            productViewRequestModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result =
          ProductViewResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        productViewData = result.data;
        productDetails = productViewData?.productDetails;
        productUnitDetail = productViewData?.productUnitDetails;
        similarProduct = productViewData?.similarProducts;
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
