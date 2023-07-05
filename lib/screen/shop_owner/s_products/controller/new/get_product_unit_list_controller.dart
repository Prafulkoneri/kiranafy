import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/view/s_kyc_approved.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/view/s_kyc_completed.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_my_subscription/model/get_subscription_history_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_my_subscription/view/s_my_subscription_plans_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/new_model/s_get_product_unit_list_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/new/get_product_unit_list_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/view/s_shop_configuration_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/model/s_buy_subscription_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/model/s_subscription_plans_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/repository/s_buy_subscription_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/repository/subscription_plan_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/view/s_subscription_view.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SGetProductUnitListController extends ChangeNotifier {
  bool isLoading = false;
  String productId = "";
  String producttype = "";
  bool isInfoLoading = true;
  GetProductUnitListData? getproductunitlistdata;
  List<UnitDetail>? unitDetails;
  List<UnitList>? unitList;

  GetUnitProductListRepo getUnitProductListRepo = GetUnitProductListRepo();

  Future<void> initState(context, pId, pType) async {
    await getUnitProductList(context, pId, pType);
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
    showLoader(true);
    productId = pId.toString();
    producttype = pType;
    SharedPreferences pref = await SharedPreferences.getInstance();

    LoadingOverlay.of(context).show();
    getUnitProductListRepo
        .getUnitProductList(
            getProductUnitListRequestModel, pref.getString("successToken"))
        .then((response) async {
      final result =
          GetProductUitListResponseModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        LoadingOverlay.of(context).hide();
        getproductunitlistdata = result.getproductunitlistdata;
        unitDetails = getproductunitlistdata?.unitDetails;
        // unitList =unitDetails?.unitList;

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
    // } else {
    //   Utils.showPrimarySnackbar(context, "Please Select Add On Services",
    //       type: SnackType.error);
    // }
  }
}
