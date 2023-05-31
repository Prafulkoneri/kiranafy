import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:local_supper_market/screen/customer/category/model/product_as_per_category_model.dart';
import 'package:local_supper_market/screen/customer/category/repository/product_as_per_category_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductCategoryController extends ChangeNotifier {
  ProductAsPerCategoryRepo productAsPerCategoryRepo =
      ProductAsPerCategoryRepo();
  String categoryId = "";
  String shopId = "";
  CategoryProductData? categoryProductData;
  List<AllCategoryList>? allCategoryList;
  List<ProductList>? productList;
  bool isLoading = true;

  Future<void> initState(context, shopId, categoryId) async {
    await getProductList(context, shopId, categoryId);
  }

  ProductAsPerCategoryReqModel get productAsPerCategoryReqModel =>
      ProductAsPerCategoryReqModel(
        categoryId: categoryId,
        shopId: shopId,
      );

  Future<void> getProductList(context, sId, cId) async {
    shopId = sId;
    categoryId = cId;
    isLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    productAsPerCategoryRepo
        .getProductDetails(
            productAsPerCategoryReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result =
          ProductAsPerCategoryResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        categoryProductData = result.data;
        allCategoryList = categoryProductData?.allCategoryList;
        productList = categoryProductData?.productList;
        if (productList!.isEmpty) {
          Utils.showPrimarySnackbar(context, "no product found",
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
