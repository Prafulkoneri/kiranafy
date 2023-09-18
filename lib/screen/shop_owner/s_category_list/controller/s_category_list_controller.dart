import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_category_list/model/s_get_selected_categories_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_category_list/repository/s_get_selected_categories_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_selected_products_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/view/s_select_category_view.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SCategoryListController extends ChangeNotifier {
  ShopSelectedCategoriesRepo SelectedCategoriesListRepo =
      ShopSelectedCategoriesRepo();

  List<SelectedCategoryData>? selectedCategoriesList;
  bool isLoading = true;

  Future<void> initState(context) async {
    await shopOwnerSelectedCategoriesList(context);
  }

  // void onAddBtnClicked(context) {
  //   final read=Provider.of<SMainScreenController>(context);
  //   read.onNavigation(0, SSelectCategoryView(), context);
  //   read.hideBottomNavigationBar();
  //   // Navigator.push(context,
  //   //     MaterialPageRoute(builder: (context) => SSelectCategoryView()));
  // }

  // void onProductSelect(context, id) {
  //   final read=Provider.of<SMainScreenController>(context);
  //   read.onNavigation(0, SSelectedProductView(
  //       isRefresh: true, categoryId: id.toString()), context);
  //   read.hideBottomNavigationBar();
  //   // Navigator.push(
  //   //     context,
  //   //     MaterialPageRoute(
  //   //         builder: (context) => SSelectedProductView(
  //   //             isRefresh: true, categoryId: id.toString())));
  // }

  ////////////////// shop owner get selected categories list/////
  Future<void> shopOwnerSelectedCategoriesList(context) async {
    isLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    SelectedCategoriesListRepo.shopSelectedCategoriesList(
            pref.getString("successToken"))
        .then((response) {
      print(response.statusCode);
      log(response.body);
      final result =
          GetSelectedCategoryResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        selectedCategoriesList = result.selectedcategorydata;
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
