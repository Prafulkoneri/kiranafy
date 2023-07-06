import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/new_model/delete_product_unit_category_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/new_model/s_get_product_unit_list_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/new/delete_unit_product_category_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/new/get_product_unit_list_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SGetProductUnitListController extends ChangeNotifier {
  bool isLoading = true;
  String productId = "";
  String productUnitId = "";
  String producttype = "";
  bool isInfoLoading = true;
  GetProductUnitListData? getproductunitlistdata;
  List<UnitDetail>? unitDetails;
  ProductDetails? productDetails;

  GetUnitProductListRepo getUnitProductListRepo = GetUnitProductListRepo();
  DeleteUnitProductCategoryRepo deleteUnitProductCategoryRepo =
      DeleteUnitProductCategoryRepo();

  Future<void> initState(context, pId, pType,refresh) async {
    showLoader(false);
if(refresh){
  await getUnitProductList(context, pId, pType);
}




  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  showInfoLoader(value) {
    isInfoLoading = value;
    notifyListeners();
  }

  GetProductUitListRequestModel get getProductUnitListRequestModel =>
      GetProductUitListRequestModel(
          productId: productId, productType: producttype);

  Future<void> getUnitProductList(context, pId, pType) async {
    print("unitReqData");
    productId = pId;
    producttype = pType;
    print(pId);
    print(pType);
    print("unitReqData");
    SharedPreferences pref = await SharedPreferences.getInstance();
    showLoader(true);
    getUnitProductListRepo
        .getUnitProductList(
            getProductUnitListRequestModel, pref.getString("successToken"))
        .then((response) async {
      final result =
          GetProductUitListResponseModel.fromJson(jsonDecode(response.body));
      print("uiiiiiiiiiiiiiiiiiiiiiiiiiii");
      log(response.body);
      print("uiiiiiiiiiiiiiiiiiiiiiiiiiii");
      if (response.statusCode == 200) {
        getproductunitlistdata = result.getproductunitlistdata;
        productDetails = getproductunitlistdata?.productDetails;

        unitDetails = getproductunitlistdata?.unitDetails;

        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
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
  /////////////////////////////////DELETE///////////////////////

  DeleteProductUnitCategoryRequestModel
      get deleteProductUnitCategoryListRequestModel =>
          DeleteProductUnitCategoryRequestModel(
              productType: producttype, productUnitId: productUnitId);

  Future<void> deleteProductUnitOfCategory(context, index, pUnitId) async {
    productUnitId = pUnitId;
    // producttype = pType;
    // couponId = couponsId.toString();
    LoadingOverlay.of(context).show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    deleteUnitProductCategoryRepo
        .deleteUnitProductCategory(deleteProductUnitCategoryListRequestModel,
            pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result =
          DeleteProductUnitCategoryResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if (result.status == 200) {
          unitDetails?.removeAt(index);
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.success);
          LoadingOverlay.of(context).hide();
        } else {
          LoadingOverlay.of(context).hide();
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
}
