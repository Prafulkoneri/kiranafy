import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_category_list/model/s_get_selected_categories_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_category_list/repository/s_get_selected_categories_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_products_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/view/s_select_category_view.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../s_products/view/shop_custome_products_view.dart';

class SCategoryListController extends ChangeNotifier {
  ShopSelectedCategoriesRepo SelectedCategoriesListRepo =
      ShopSelectedCategoriesRepo();

  List<SelectedCategoryData>? selectedCategoriesList;

  Future<void> initState(context) async {
    await shopOwnerSelectedCategoriesList(context);
  }

  void onAddBtnClicked(context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SSelectCategoryView()));
  }

  void onProductSelect(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ShopProductView()));
  }

  void onCustomProductSelect(context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ShopCustomProductView()));
  }

  ////////////////// shop owner get selected categories list/////
  Future<void> shopOwnerSelectedCategoriesList(context) async {
    SharedPreferences pref=await SharedPreferences.getInstance();
    SelectedCategoriesListRepo.shopSelectedCategoriesList(pref.getString("successToken")).then((response) {
      print(response.statusCode);
      print(response.body);
      final result =
          GetSelectedCategoryResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        print("${response.body}");
        selectedCategoriesList = result.data;
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
