import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/selected_products_model.dart';

import 'package:local_supper_market/screen/shop_owner/s_products/model/shop_add_product_list_model.dart';

import 'package:local_supper_market/screen/shop_owner/s_products/repository/shop_add_product_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_add_product_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/shop_custome_products_view.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/selected_products_repo.dart';

class ShopGetSelectedProducts extends ChangeNotifier {
  bool isLoading = true;
  // List<SelectedProducts>? selectedProductList;
  List<ProductsFromAdmin>? productsFromAdmin;
  List<UnitDetail>? unitDetails;
  int? totalSelectedAndCustomProducts;
  SelectedProductsRepo shopSelecteProductRepo = SelectedProductsRepo();
  String categoryId = "";
  Future<void> initState(context, id) async {
    print("object");
    print(id);
    await selectedProducts(context, id);
    notifyListeners();
  }

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

  //////////////Select product
  SelecteProductsRequestModel get selecteProductRequestModel =>
      SelecteProductsRequestModel(category_id: "6");

  Future<void> selectedProducts(context, id) async {
    print("hello");
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
        print(productsFromAdmin?[0].unitDetails);

        totalSelectedAndCustomProducts =
            result.data?.totalSelectedAndCustomProducts ?? 0;

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