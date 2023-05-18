import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/selected_products_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/selected_products_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_add_product_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/shop_custome_products_view.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SAddProductsController extends ChangeNotifier {
  bool isLoading = true;
  List<SelectedProducts>? selectedProductList;

  SelectedProductsRepo selectedProductRepo = SelectedProductsRepo();
  List<bool> selectedList = [];
  String categoryId = "";
  Future<void> initState(context, id) async {
    print("object");
    print(id);
    await selectedProducts(context, id);
    notifyListeners();
  }

  // void onProductSelected(index, id) {
  //   selectedList[index] = !selectedList[index];
  //   if (selectedList[index]) {
  //     selectedId.removeWhere((item) => item == id);
  //     selectedId.insert(0, id);
  //   } else {
  //     selectedId.removeWhere((item) => item == id);
  //   }
  //   print(selectedId);
  //   notifyListeners();
  // }

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

  ////////////////Select product
  SelecteProductsRequestModel get selecteProductRequestModel =>
      SelecteProductsRequestModel(category_id: "6");

  Future<void> selectedProducts(context, id) async {
    print("hello");
    SharedPreferences pref = await SharedPreferences.getInstance();
    categoryId = id;
    selectedProductRepo
        .selectedProducts(
            selecteProductRequestModel, pref.getString("successToken"))
        .then((response) {
      print(response.body);
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
