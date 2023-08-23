import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';

import 'package:local_supper_market/screen/shop_owner/s_products/model/shop_add_product_list_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/upload_add_product_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/s_selected_products_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/s_add_product_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/upload_add_products_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_add_product_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_selected_products_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_custom_products_view.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SAddProductsController extends ChangeNotifier {
  bool isLoading = true;

  ShopAddProductRepo shopAddProductRepo = ShopAddProductRepo();
  UploadAddProductRepo uploadAddProductRepo = UploadAddProductRepo();

  // List<bool> selectedList = [];
  Data? productData;
  List<ProductDetail>? productDetails;
  List<ProductDetail> allAdminProductList=[];
  List<bool> selectedProduct = [];
  List selectedProductsId = [];
  int? allProductsCount;
  String categoryId = "";
  String productId = "";
  bool isSelectAll = false;
  String categoryName = "";
  bool uploadSuccess = false;
  bool showPaginationLoader = false;
  MainScreenController mainScreenController = MainScreenController();
int offset=0;
  Future<void> initState(context, id,refresh) async {
    if(refresh){
      allAdminProductList.clear();
      offset=0;
      await shopAddProducts(context, id);
    }

    notifyListeners();
  }

  showLoader(value){
    isLoading=value;
    notifyListeners();
  }

//////to dlectect Ptroducts
  void onProductsSelected(index, id) {
    selectedProduct[index] = !selectedProduct[index];
    if (selectedProduct[index]) {
      selectedProductsId.removeWhere((item) => item == int.parse(id));
      selectedProductsId.insert(0, id);
    } else {
      selectedProductsId.removeWhere((item) => item == int.parse(id));
    }

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
      ShopAddProductsListRequestModel(category_id: categoryId,limit: "10",offset:offset.toString() );

  Future<void> shopAddProducts(context, id) async {
    isSelectAll = false;
    if(offset==0){
      showLoader(true);

    }

    showPaginationLoader = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    categoryId = id.toString();
    print("categoryId$categoryId");
    shopAddProductRepo
        .shopAddProducts(
            shopAddProductRequestModel, pref.getString("successToken"))
        .then((response) {
      log("response${response.body}");
      final result =
          ShopAddProductsListResponse.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        productData = result.data;
        productDetails = result.data?.productDetails;
        allAdminProductList.clear();
        allAdminProductList.addAll(productDetails??[]);
        categoryName = result.data?.categoryName ?? "";
        allProductsCount = productData?.allProductsCount ?? 0;

        selectedProduct = List<bool>.filled(allAdminProductList.length ?? 0, false,
            growable: true);
        int allcheckedProductListLength=productDetails?.length??0;
        List checkedProductList=[];
        for(int i=0;i<allcheckedProductListLength;i++){
          if(productDetails?[i].selectedByShopOwner=="yes"){
            checkedProductList.add(productDetails?[i].selectedByShopOwner);
          }
        }
        print(checkedProductList.length);
        if(checkedProductList.length==allProductsCount){
          isSelectAll=true;
        }
        else{
          isSelectAll=false;
        }
        int length = allAdminProductList.length ?? 0;
        selectedProductsId.clear();
        for (int i = 0; i < length; i++) {
          if (allAdminProductList[i].selectedByShopOwner == "yes") {
            selectedProduct.insert(i, true);
            selectedProductsId.add(allAdminProductList[i].id);
          }
        }
        showLoader(false);
        showPaginationLoader=false;
        notifyListeners();
      } else {
        showLoader(false);
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

  UploadAddProductsRequestModel get uploadAddProductsRequestModel =>
      UploadAddProductsRequestModel(
        product_id: productId,
        category_id: categoryId,
      );

  Future<void> uploadAddProducts(context) async {
    uploadSuccess = true;

    if (selectedProductsId.isEmpty) {
      Utils.showPrimarySnackbar(context, "Select Product",
          type: SnackType.error);
    } else {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String a = '';
      for (int i = 0; i < selectedProductsId.length; i++) {
        a += "${selectedProductsId[i]},";
      }
      a = a.substring(0, a.length - 1);
      productId = a;
      LoadingOverlay.of(context).show();
      uploadAddProductRepo
          .uploadAddProduct(
              uploadAddProductsRequestModel, pref.getString("successToken"))
          .then((response) {
        print(response.body);
        final result =
            UploadAddProductResponseModel.fromJson(jsonDecode(response.body));

        if (response.statusCode == 200) {
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.success);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => SMainScreenView(
                      index: 0,
                      screenName: SSelectedProductView(categoryId: categoryId,isRefresh: true),
                    )),
            (Route<dynamic> route) => false,
          );

          notifyListeners();
          uploadSuccess = false;
          LoadingOverlay.of(context).hide();
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

  Future<void> onScrollMaxExtent(context) async {
    print("hello");
    offset = offset + 1;
    showPaginationLoader = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("categoryId$categoryId");
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
        allAdminProductList.addAll(productDetails??[]);
        categoryName = result.data?.categoryName ?? "";
        allProductsCount = productData?.allProductsCount ?? 0;
        print(isSelectAll);
        if(isSelectAll){
          selectedProduct = List<bool>.filled(allAdminProductList.length ?? 0, true,
              growable: true);
          selectedProductsId.clear();
          int length = allAdminProductList.length ?? 0;
          for (int i = 0; i < length; i++) {
            if (allAdminProductList[i].selectedByShopOwner == "yes") {
              selectedProduct.insert(i, true);
              selectedProductsId.add(allAdminProductList[i].id);
            }
          }
        }
        else{
          selectedProduct = List<bool>.filled(allAdminProductList.length ?? 0, false,
              growable: true);
        }



        print(selectedProductsId);
        showLoader(false);
        showPaginationLoader=false;
        notifyListeners();
      } else {
        showLoader(false);
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
    notifyListeners();
  }

  upload(context) async {
    bool? status;
    await uploadAddProducts(context).then((value) {
      status = true;
    });
    return status;
  }

  void onSelecteAllProducts(context)async {
    isSelectAll = !isSelectAll;

    print(isSelectAll);
    if (isSelectAll) {
      LoadingOverlay.of(context).show();
      selectedProductsId.clear();
      SharedPreferences pref = await SharedPreferences.getInstance();
      print("categoryId$categoryId");
      shopAddProductRepo
          .shopAddProducts(
          ShopAddProductsListRequestModel(category_id: categoryId,limit: "5000",offset:"0"), pref.getString("successToken"))
          .then((response) {
        print(response.body);
        final result =
        ShopAddProductsListResponse.fromJson(jsonDecode(response.body));

        if (response.statusCode == 200) {
          productData = result.data;
          productDetails = result.data?.productDetails;
          selectedProduct = List<bool>.filled(allAdminProductList.length ?? 0, true,
                growable: true);

int length=productDetails?.length??0;
          for (int i = 0; i < length; i++) {
            print("hello");
            print(productDetails?[i].id);
            print("hello");
            selectedProductsId.add(productDetails?[i].id);
          }
          print(selectedProductsId);
          // showPaginationLoader=false;
          LoadingOverlay.of(context).hide();
          notifyListeners();
        } else {
          LoadingOverlay.of(context).hide();
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
      notifyListeners();

      print(selectedProductsId);
    } else {
      selectedProduct =
          List<bool>.filled(allAdminProductList.length ?? 0, false, growable: true);
      selectedProductsId.clear();
      print("not selected");
    print(selectedProductsId);
      print("not selected");
    }


    notifyListeners();
  }
}
