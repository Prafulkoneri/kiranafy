import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/selected_products_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/selected_products_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_add_product_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/shop_custome_products_view.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SAddProductsController extends ChangeNotifier {
  SelectedProductsRepo selectedProductRepo = SelectedProductsRepo();
  void onAddProductClick(context) {
    print("hello");
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddProductView()));
  }

  void onCustomeAddProductClick(context) {
    print("hello");
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ShopCustomProductView()));
  }

  ////////////////Select Category
  SelecteProductsRequestModel get selecteProductRequestModel =>
      SelecteProductsRequestModel();

  Future<void> selectedProducts(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    selectedProductRepo
        .selectedProducts(
            selecteProductRequestModel, pref.getString("successToken"))
        .then((response) {
      final result =
          GetSelectedProductsResponseModel.fromJson(jsonDecode(response.body));

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
