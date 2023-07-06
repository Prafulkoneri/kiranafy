import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/delete_admin_product_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/search_product_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/selected_products_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/shop_add_product_list_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/delete_admin_product_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/s_add_product_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/search_product_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_add_product_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_custom_products_view.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/s_selected_products_repo.dart';

class SSelectedProductsController extends ChangeNotifier {
  bool isLoading = true;

  // List<SelectedProducts>? selectedProductList;
  List<ProductsFromAdmin>? productsFromAdmin;
  List<UnitDetail>? unitDetails;
  int? totalSelectedAndCustomProducts;
  String categoryName = "";
  SSelectedProductsRepo shopSelecteProductRepo = SSelectedProductsRepo();
  SearchProductRepo searchProductRepo = SearchProductRepo();
  TextEditingController searchController = TextEditingController();
  DeleteAdminProductRepo deleteAdminProductRepo = DeleteAdminProductRepo();
  String categoryId = "";
  String productId = "";
  String productName = "";
  List<CustomProduct>? customProduct;

  Future<void> initState(context, id, refresh) async {
    searchController.clear();
    if (refresh) {
      await selectedProducts(context, id);
    }

    notifyListeners();
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  //////////////Select product
  SelecteProductsRequestModel get selecteProductRequestModel =>
      SelecteProductsRequestModel(category_id: categoryId);

  DeleteAdminProductReqModel get deleteAdminProductReqModel =>
      DeleteAdminProductReqModel(productId: productId);

  Future<void> selectedProducts(context, id) async {
    categoryId = id;
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    shopSelecteProductRepo
        .selectedProducts(
            selecteProductRequestModel, pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result =
          GetSelectedProductsResponseModel.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        productsFromAdmin = result.data?.productsFromAdmin;
        categoryName = result.data?.categoryName ?? "";
        customProduct = result.data?.customProduct;
        totalSelectedAndCustomProducts =
            result.data?.totalSelectedAndCustomProducts ?? 0;

        // Utils.showPrimarySnackbar(context, result.message,
        //     type: SnackType.success);
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

  void onAddProductPressed(context, id) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => SMainScreenView(
                index: 0,
                screenName: AddProductView(categoryId: id,refresh: true,),
              )),
      (Route<dynamic> route) => false,
    );
  }

  Future<void> deleteAdminProduct(context, index, id) async {
    productId = id.toString();
    isLoading = true;
    LoadingOverlay.of(context).show();
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
          LoadingOverlay.of(context).hide();
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

  Future<void> deleteCustomProduct(context, index, id) async {
    productId = id.toString();
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

//////////////////////////////////////////////////////////////////////////////////////////
  SearchProductRequestModel get searchProductRequestModel =>
      SearchProductRequestModel(
          categoryId: categoryId, productName: searchController.text);

  Future<void> searchProductList(
    context,
    cId,
  ) async {
    categoryId = cId;
    // productName = pName;

    if (searchController.text.isNotEmpty) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      print(pref.getString("successToken"));
      searchProductRepo
          .searchProduct(
              searchProductRequestModel, pref.getString("successToken"))
          .then((response) {
        log("response.body${response.body}");
        final result = GetSelectedProductsResponseModel.fromJson(
            jsonDecode(response.body));
        if (response.statusCode == 200) {
          productsFromAdmin = result.data?.productsFromAdmin;
          categoryName = result.data?.categoryName ?? "";
          customProduct = result.data?.customProduct;
          totalSelectedAndCustomProducts =
              result.data?.totalSelectedAndCustomProducts ?? 0;
          // categoryProductData = result.data;
          // allCategoryList = categoryProductData?.allCategoryList;
          // productList = categoryProductData?.productList;
          // if (productList!.isEmpty) {
          //   Utils.showPrimarySnackbar(context, "no product found",
          //       type: SnackType.error);
          // }

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
      await selectedProducts(context, cId);
    }
  }
}
