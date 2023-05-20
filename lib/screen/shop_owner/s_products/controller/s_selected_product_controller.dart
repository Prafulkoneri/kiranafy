import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/delete_admin_product_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/selected_products_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/shop_add_product_list_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/delete_admin_product_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/s_add_product_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_add_product_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/shop_custome_products_view.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/s_selected_products_repo.dart';

class SSelectedProductsController extends ChangeNotifier {
  bool isLoading = true;

  // List<SelectedProducts>? selectedProductList;
  List<ProductsFromAdmin>? productsFromAdmin;
  List<UnitDetail>? unitDetails;
  int? totalSelectedAndCustomProducts;
  SSelectedProductsRepo shopSelecteProductRepo = SSelectedProductsRepo();
  DeleteAdminProductRepo deleteAdminProductRepo = DeleteAdminProductRepo();
  String categoryId = "";


  Future<void> initState(context, id) async {
    await selectedProducts(context, id);
    notifyListeners();
  }




  //////////////Select product
  SelecteProductsRequestModel get selecteProductRequestModel =>
      SelecteProductsRequestModel(category_id: "6");

  DeleteAdminProductReqModel get deleteAdminProductReqModel =>
      DeleteAdminProductReqModel(productId: "6");

  Future<void> selectedProducts(context, id) async {
    isLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    categoryId = id;
    shopSelecteProductRepo
        .selectedProducts(
            selecteProductRequestModel, pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result =
          GetSelectedProductsResponseModel.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        productsFromAdmin = result.data?.productsFromAdmin;

        totalSelectedAndCustomProducts =
            result.data?.totalSelectedAndCustomProducts ?? 0;

        // Utils.showPrimarySnackbar(context, result.message,
        //     type: SnackType.success);
        isLoading = false;
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

  Future<void> deleteProduct(context, index) async {
    isLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();

    deleteAdminProductRepo
        .deleteProduct(
            deleteAdminProductReqModel, pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result =
          DeleteAdminProductResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if (result.status == 200) {
          productsFromAdmin?.removeAt(index);
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.success);
        } else {
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
        }

        isLoading = false;
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
