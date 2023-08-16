import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:local_supper_market/screen/customer/cart/model/add_product_to_cart_model.dart';
import 'package:local_supper_market/screen/customer/cart/repository/add_product_to_cart_repo.dart';
import 'package:local_supper_market/screen/customer/category/model/filtter_model.dart';
import 'package:local_supper_market/screen/customer/category/model/product_as_per_category_model.dart';
import 'package:local_supper_market/screen/customer/category/model/seach_product_as_per_category_model.dart';
import 'package:local_supper_market/screen/customer/category/repository/product_as_per_category_repo.dart';
import 'package:local_supper_market/screen/customer/category/repository/product_as_per_filter_repo.dart';
import 'package:local_supper_market/screen/customer/category/repository/search_product_as_per_category_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductCategoryController extends ChangeNotifier {
  ProductAsPerCategoryRepo productAsPerCategoryRepo =
      ProductAsPerCategoryRepo();
  String categoryId = "";
  String shopId = "";
  CategoryProductData? categoryProductData;
  List<AllCategoryList>? allCategoryList;
  List<CustomerProductData>? productList;
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();
  String searchedProductName = "";
  bool isOfferProductSelected = false;
  String groupValue = "1";
  List<bool> isCategoryProductAdded = [];
  AddProductToCartRepo addProductToCartRepo = AddProductToCartRepo();
  SearchProductAsPerCategoryRepo searchProductAsPerCategoryRepo =
      SearchProductAsPerCategoryRepo();

  ProductAsPerFilterRepo productAsPerFilterRepo = ProductAsPerFilterRepo();

  Future<void> initState(context, shopId, categoryId) async {
    await getProductList(context, shopId, categoryId);
  }

  void showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  ProductAsPerCategoryReqModel get productAsPerCategoryReqModel =>
      ProductAsPerCategoryReqModel(
        categoryId: categoryId,
        shopId: shopId,
      );

  Future<void> getProductList(context, sId, cId) async {
    shopId = sId;
    categoryId = cId;
    searchController.clear();
    showLoader(true);
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
///////////////////////////
        int productListLength = productList?.length ?? 0;
        isCategoryProductAdded =
            List<bool>.filled(productListLength, false, growable: true);
        for (int i = 0; i < productListLength; i++) {
          if (productList?[i].addToCartCheck == "yes") {
            isCategoryProductAdded.insert(i, true);
          } else {
            isCategoryProductAdded.insert(i, false);
          }
        }
        if (productList!.isEmpty) {
          Utils.showPrimarySnackbar(context, "No Product Found",
              type: SnackType.error);
        }
        showLoader(false);
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

////////////////////////////

  void onCategoryProductSelected(index) {
    isCategoryProductAdded[index] = true;
    notifyListeners();
  }

  ///

  SearchProductAsPerCategoryReqModel get searchProductAsPerCategoryReqModel =>
      SearchProductAsPerCategoryReqModel(
        categoryId: categoryId,
        shopId: shopId,
        productName: searchController.text,
      );

  Future<void> getSearchList(context, sId, cId) async {
    showLoader(true);
    if (searchController.text.isNotEmpty) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      print(pref.getString("successToken"));
      searchProductAsPerCategoryRepo
          .getSearchProductList(searchProductAsPerCategoryReqModel,
              pref.getString("successToken"))
          .then((response) {
        log("response.body${response.body}");
        final result = SearchProductAsPerCategoryResModel.fromJson(
            jsonDecode(response.body));
        if (response.statusCode == 200) {
          categoryProductData = result.data;
          allCategoryList = categoryProductData?.allCategoryList;
          productList = categoryProductData?.productList;
          if (productList!.isEmpty) {
            Utils.showPrimarySnackbar(context, "no product found",
                type: SnackType.error);
          }
          showLoader(false);
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
    } else {
      await getProductList(context, sId, cId);
    }
  }

  void onOfferProductFilterSelect(value) {
    isOfferProductSelected = value;
    notifyListeners();
  }

  void onRadioBtnSelected(value) {
    groupValue = value;
    notifyListeners();
  }

  ProductFilterReqModel get productFilterReqModel => ProductFilterReqModel(
        shopId: shopId,
        categoryId: categoryId,
        offerProducts: isOfferProductSelected ? "yes" : "no",
        priceHighToLow: groupValue == "2" ? "yes" : "no",
        priceLowToHigh: groupValue == "1" ? "yes" : "no",
      );

  Future<void> getFilterProductList(context) async {
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    productAsPerFilterRepo
        .getProductAsPerFilter(
            productFilterReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result =
          ProductAsPerCategoryResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        allCategoryList = result.data?.allCategoryList;
        productList = result.data?.productList;
        Navigator.pop(context);
        if (productList!.isEmpty) {
          Utils.showPrimarySnackbar(context, "No Product Found",
              type: SnackType.error);
        }
        showLoader(false);
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

  Future<void> addToCart(pType, pId, sId, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    addProductToCartRepo
        .addProductToCart(
            AddProductToCartReqModel(
                productType: pType,
                productUnitId: pId.toString(),
                shopId: sId.toString(),
                quantity: "1"),
            pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result =
          AddProductToCartResModel.fromJson(jsonDecode(response.body));
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
