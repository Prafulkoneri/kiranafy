import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_category_list/view/s_category_list_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/model/s_categories_list_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/repository/s_categories_list_repo.dart';
import 'package:local_supper_market/utils/Utils.dart';

class SSelectCategoryController extends ChangeNotifier {
  ShopAllCategoriesRepo categoriesListRepo = ShopAllCategoriesRepo();
  List<CategoryData>? categoriesList;

  Future<void> initState(context) async {
    await getCategoriesList(context);
  }

  void onAppBarActionPressed(context) {
    print("hello");
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SSCategoryListView()));
  }

  /////////////////////////////////  Start All Categories List/////////////////////
  Future<void> getCategoriesList(context) async {
    categoriesListRepo.shopAllCategoriesList().then((response) {
      print(response.statusCode);
      print(response.body);
      final result =
          AllCategoryResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        print("${response.body}");
        categoriesList = result.data;
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
