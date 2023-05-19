import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:local_supper_market/screen/shop_owner/s_products/model/shop_add_product_list_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/upload_add_product_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/selected_products_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/shop_add_product_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/upload_add_products_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_add_product_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/shop_custome_products_view.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SAddProductsController extends ChangeNotifier {
  bool isLoading = true;

  ShopAddProductRepo shopAddProductRepo = ShopAddProductRepo();
  UploadAddProductRepo uploadAddProductRepo = UploadAddProductRepo();
  // List<bool> selectedList = [];
  Data? productData;
  List<ProductDetail>? productDetails;
  List<bool> selectedProduct = [];
  List selectedProductsId = [];
  int? allProductsCount;
  String categoryId = "";
  String productId = "";
  bool isSelectAll = false;
  Future<void> initState(context, id) async {
    print("object");
    print(id);
    await shopAddProducts(context, id);
    notifyListeners();
  }

//////to dlectect Ptroducts
  void onProductsSelected(index, id) {
    selectedProduct[index] = !selectedProduct[index];
    if (selectedProduct[index]) {
      print(selectedProductsId);
      selectedProductsId.removeWhere((item) => item == int.parse(id));
      selectedProductsId.insert(0, id);
    } else {
      selectedProductsId.removeWhere((item) => item == int.parse(id));
    }
    print(selectedProductsId);
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

  //////End

  ////Shop owner Add Products Start

  ShopAddProductsListRequestModel get shopAddProductRequestModel =>
      ShopAddProductsListRequestModel(category_id: "6");

  Future<void> shopAddProducts(context, id) async {
    print("hello");
    SharedPreferences pref = await SharedPreferences.getInstance();
    categoryId = id.toString();
    shopAddProductRepo
        .shopAddProducts(
            shopAddProductRequestModel, pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result =
          ShopAddProductsListResponse.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        productData = result.data;
        productDetails = result.data?.productDetails;
        allProductsCount = productData?.allProductsCount ?? 0;

        selectedProduct = List<bool>.filled(productDetails?.length ?? 0, false,
            growable: true);
        int length = productDetails?.length ?? 0;
        selectedProductsId.clear();
        for (int i = 0; i < length; i++) {
          if (productDetails?[i].selectedByShopOwner == "yes") {
            selectedProduct.insert(i, true);
            selectedProductsId.add(productDetails?[i].id);
          }
        }
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

  void onSelecteAllProducts() {
    print("object");
    isSelectAll = !isSelectAll;
    if (isSelectAll) {
      selectedProduct =
          List<bool>.filled(productDetails?.length ?? 0, true, growable: true);
      int length = productDetails?.length ?? 0;
      selectedProductsId.clear();
      for (int i = 0; i < length; i++) {
        selectedProductsId.add(productDetails?[i].id);
      }
    } else {
      selectedProduct =
          List<bool>.filled(productDetails?.length ?? 0, false, growable: true);
      selectedProductsId.clear();
    }
    print(selectedProductsId);
    notifyListeners();
  }

  UploadAddProductsRequestModel get uploadAddProductRequestModel =>
      UploadAddProductsRequestModel(category_id: "6");

  Future<void> uploadAddProduct(context, id) async {
    print("hello");
    SharedPreferences pref = await SharedPreferences.getInstance();
    categoryId = id.toString();
    productId = id.toString();
    uploadAddProductRepo
        .uploadAddProduct(
            uploadAddProductRequestModel, pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result =
          UploadAddProductResponseModel.fromJson(jsonDecode(response.body));

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
