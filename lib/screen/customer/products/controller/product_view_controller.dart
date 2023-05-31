import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:local_supper_market/screen/customer/products/model/product_unit_images_res_model.dart';
import 'package:local_supper_market/screen/customer/products/model/product_view_model.dart';
import 'package:local_supper_market/screen/customer/products/repository/product_unit_image_repo.dart';
import 'package:local_supper_market/screen/customer/products/repository/product_view_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductViewController extends ChangeNotifier {
  String? shopId = "";
  String? categoryId = "";
  String? productId = "";
  String? selectedUnitId = "";
  String? productImage = "";
  ProductViewData? productViewData;
  ProductDetails? productDetails;
  ShopDetails? shopDetails;
  List<ProductUnitDetail>? productUnitDetail;
  List<SimilarProduct>? similarProduct;
  // UnitImages? unitImages; ////
  List unitImages = [];
  ProductViewRepo productViewRepo = ProductViewRepo();
  ProductUnitImageRepo productUnitImageRepo = ProductUnitImageRepo();
  Future<void> initState(context, sId, cId, pId, suId) async {
    await productsView(context, sId, cId, pId);
    unitImages.clear();
    // await productsUnitImage(context, suId);
    notifyListeners();
  }

  ProductViewRequestModel get productViewRequestModel =>
      ProductViewRequestModel(
          shopId: shopId, categoryId: categoryId, productId: productId);

  Future<void> productsView(context, sId, cId, pId) async {
    // print("id$id");
    print("helohhhhhhhhooooooooooooo");
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
        productImage = productDetails?.productImagePath;
        shopDetails = productViewData?.shopDetails;
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

  /////////////////////Product Unit Image/////////////////////

  UnitImagesRequestModel get unitImagesReqModel =>
      UnitImagesRequestModel(slectedUnitId: selectedUnitId);

  Future<void> productsUnitImage(context, suId) async {
    // print("id$id");
    print("bybeeeeeeeeeeeeeeeeeeeeeeeee");
    selectedUnitId = suId;
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    productUnitImageRepo
        .productUnitImageRepo(
            unitImagesReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result =
          UnitImagesResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        // unitImages = result.data;
        // productImage = unitImages?.unitBasedProductImagePath;
        unitImages = result.data?.unitBasedProductImagePath ?? [];
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
