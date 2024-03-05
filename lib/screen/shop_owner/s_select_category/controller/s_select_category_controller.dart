import 'dart:convert';
import 'dart:developer';

import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_category_list/view/s_category_list_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/model/s_add_categories_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/model/s_categories_list_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/repository/s_add_category_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/repository/s_categories_list_repo.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SSelectCategoryController extends ChangeNotifier {
  ShopAllCategoriesRepo categoriesListRepo = ShopAllCategoriesRepo();
  AddCategoryRepo addCategoryRepo = AddCategoryRepo();
  List<CategoryData>? categoriesList;
  List<bool> selectedCategoryList = [];
  List selectedCategoryId = [];
  String selectedId = "";
  bool isLoading = true;

  Future<void> initState(context) async {
    await getCategoriesList(context);

    notifyListeners();
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
    isLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    categoriesListRepo
        .shopAllCategoriesList(pref.getString("successToken"))
        .then((response) {
      print(response.statusCode);
      log("response.body${response.body}");
      final result =
          AllCategoryResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        categoriesList = result.data;
        selectedCategoryList = List<bool>.filled(
            categoriesList?.length ?? 0, false,
            growable: true);
        int length = categoriesList?.length ?? 0;
        selectedCategoryId.clear();
        for (int i = 0; i < length; i++) {
          if (categoriesList?[i].selectedByShopOwner == "yes") {
            selectedCategoryList.insert(i, true);
            selectedCategoryId.add(categoriesList?[i].id);
          }
        }
        print(selectedCategoryList);
        print(selectedCategoryId);
        isLoading = false;
        notifyListeners();
      }
      else if(response.statusCode == 401){
        Utils().logoutUser(context);
      }
      else {
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
        final read =Provider.of<SMainScreenController>(context,listen: false);
        read.onNavigation(0,const SSCategoryListView(), context);
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) =>
        //           SMainScreenView(index: 0, screenName: SSCategoryListView())),
        //   (Route<dynamic> route) => false,
        // );
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
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
