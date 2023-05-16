import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_category_list/view/s_category_list_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/model/s_add_categories_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/model/s_categories_list_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/repository/s_add_category_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/repository/s_categories_list_repo.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
class SSelectCategoryController extends ChangeNotifier {
  ShopAllCategoriesRepo categoriesListRepo = ShopAllCategoriesRepo();
  AddCategoryRepo addCategoryRepo = AddCategoryRepo();
  List<CategoryData>? categoriesList;
  List<bool> selectedCategoryList = [];
  List selectedCategoryId = [];
  String selectedId = "";

  Future<void> initState(context) async {
    await getCategoriesList(context);
  }

  void onCategorySelected(index, id) {
    selectedCategoryList[index] = !selectedCategoryList[index];
    if (selectedCategoryList[index]) {
      selectedCategoryId.removeWhere((item) => item == id);
      selectedCategoryId.insert(0, id);
    } else {
      selectedCategoryId.removeWhere((item) => item == id);
    }
    print(selectedCategoryId);
    notifyListeners();
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
        selectedCategoryList =
            List<bool>.filled(categoriesList?.length ?? 0, false);
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

  SAddCategoriesReqModel get sAddCategoriesReqModel => SAddCategoriesReqModel(
        categoryId: selectedId,
      );

  Future<void> addCategory(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String a = '';
    for (int i = 0; i < selectedCategoryId.length; i++) {
      a += "${selectedCategoryId[i]},";
    }
    a = a.substring(0, a.length - 1);
    selectedId = a;
    addCategoryRepo
        .addCategory(sAddCategoriesReqModel, pref.getString("successToken"))
        .then((response) {
      print(response.statusCode);
      print(response.body);
      final result = SAddCategoriesResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {

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
