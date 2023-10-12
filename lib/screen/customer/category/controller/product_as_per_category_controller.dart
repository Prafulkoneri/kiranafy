import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:local_supper_market/screen/customer/cart/model/add_product_to_cart_model.dart';
import 'package:local_supper_market/screen/customer/cart/model/cart_item_quantity_model.dart';
import 'package:local_supper_market/screen/customer/cart/repository/add_product_to_cart_repo.dart';
import 'package:local_supper_market/screen/customer/cart/repository/cart_item_quantity_repo.dart';
import 'package:local_supper_market/screen/customer/category/model/filtter_model.dart';
import 'package:local_supper_market/screen/customer/category/model/product_as_per_category_model.dart';
import 'package:local_supper_market/screen/customer/category/model/seach_product_as_per_category_model.dart';
import 'package:local_supper_market/screen/customer/category/repository/product_as_per_category_repo.dart';
import 'package:local_supper_market/screen/customer/category/repository/product_as_per_filter_repo.dart';
import 'package:local_supper_market/screen/customer/category/repository/search_product_as_per_category_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/remove_item_cart_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/repository/remove_item_from_cart_repo.dart';
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
  List<CustomerProductData>? customProductList;
  List<CustomerProductData>? finalFiltterProductList;
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();
  String searchedProductName = "";
  bool isOfferProductSelected = false;
  String groupValue = "1";
  String quantityAction = "";
  List<bool> isCategoryProductAdded = [];
  List cartItemIdList=[];
  List quantityList=[];
  bool isQuanityBtnPressed=false;
  String cartItemId = "";
  String productType = "";
  List<bool> isCustomCategoryProductAdded = [];
  AddProductToCartRepo addProductToCartRepo = AddProductToCartRepo();
  SearchProductAsPerCategoryRepo searchProductAsPerCategoryRepo =
      SearchProductAsPerCategoryRepo();

  ProductAsPerFilterRepo productAsPerFilterRepo = ProductAsPerFilterRepo();
  CartItemQuantityRepo cartItemQuantityRepo = CartItemQuantityRepo();

  Future<void> initState(context, sId, cId) async {
    shopId=sId;
    categoryId=cId;
    groupValue="1";
    isOfferProductSelected=false;
    notifyListeners();
    await getFilterProductList(context,true,cId);
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

//   Future<void> getProductList(context, sId, cId) async {
//     shopId = sId;
//     categoryId = cId;
//     searchController.clear();
//     showLoader(true);
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     print(pref.getString("successToken"));
//     productAsPerCategoryRepo
//         .getProductDetails(
//             productAsPerCategoryReqModel, pref.getString("successToken"))
//         .then((response) {
//       log("response.body${response.body}");
//       final result =
//           ProductAsPerCategoryResModel.fromJson(jsonDecode(response.body));
//       if (response.statusCode == 200) {
//         categoryProductData = result.data;
//         allCategoryList = categoryProductData?.allCategoryList;
//         productList = categoryProductData?.productList;
//         customProductList = categoryProductData?.customProductList;
//
// ///////////////////////////
//         int productListLength = productList?.length ?? 0;
//         int customproductListLength = customProductList?.length ?? 0;
//         isCategoryProductAdded =
//             List<bool>.filled(productListLength, false, growable: true);
//         isCustomCategoryProductAdded = List<bool>.filled(
//             customProductList?.length ?? 0, false,
//             growable: true);
//         for (int i = 0; i < productListLength; i++) {
//           if (productList?[i].addToCartCheck == "yes") {
//             isCategoryProductAdded.insert(i, true);
//           } else {
//             isCategoryProductAdded.insert(i, false);
//           }
//         }
//         for (int i = 0; i < customproductListLength; i++) {
//           if (customProductList?[i].addToCartCheck == "yes") {
//             isCustomCategoryProductAdded.insert(i, true);
//           } else {
//             isCustomCategoryProductAdded.insert(i, false);
//           }
//         }
//         if (productList?.isEmpty == true &&
//             customProductList?.isEmpty == true) {
//           Utils.showPrimarySnackbar(context, "No Product Found",
//               type: SnackType.error);
//         }
//         showLoader(false);
//         notifyListeners();
//       } else {
//         Utils.showPrimarySnackbar(context, result.message,
//             type: SnackType.error);
//       }
//     }).onError((error, stackTrace) {
//       Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
//     }).catchError(
//       (Object e) {
//         Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
//       },
//       test: (Object e) {
//         Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
//         return false;
//       },
//     );
//   }

////////////////////////////

  void onCategoryProductSelected(index) {
    isCategoryProductAdded[index] = true;
    notifyListeners();
  }

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
          customProductList = categoryProductData?.customProductList;
          // if (productList!.isEmpty) {
          //   Utils.showPrimarySnackbar(context, "no product found",
          //       type: SnackType.error);
          // }
          if (productList?.isEmpty == true &&
              customProductList?.isEmpty == true) {
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
    } else {
      await getFilterProductList(context,true,cId);
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

  Future<void> getFilterProductList(context,hideFilter,cId) async {
    quantityList.clear();
    cartItemIdList.clear();
    showLoader(true);
    categoryId=cId;
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    productAsPerFilterRepo
        .getProductAsPerFilter(
            productFilterReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result =
          ProductAsPerCategoryResModel.fromJson(jsonDecode(response.body));
      print(result);
      if (response.statusCode == 200) {
        allCategoryList = result.data?.allCategoryList;
        productList = result.data?.productList;
        int productListLength = productList?.length ?? 0;
        isCategoryProductAdded = List<bool>.filled(productListLength, false, growable: true);
        for (int i = 0; i < productListLength; i++) {
          cartItemIdList.add(productList?[i].cartItemId);
          quantityList.add(productList?[i].quantity);
          if (productList?[i].addToCartCheck == "yes") {
            isCategoryProductAdded.insert(i, true);
          } else {
            isCategoryProductAdded.insert(i, false);
          }
        }
        if(!hideFilter) {
          Navigator.pop(context);
        }
        if (productList?.isEmpty == true &&
            customProductList?.isEmpty == true) {
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

  Future<void> addToCart(pType, pId, sId, index, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString("status") == "guestLoggedIn") {
      Utils().showLoginDialog(context, "Please Login to add product to cart");
      return;
    }
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

          isCategoryProductAdded[index] = true;
          quantityList.removeAt(index);
          quantityList.insert(index,1);
          cartItemIdList.removeAt(index);
          cartItemIdList.insert(index,result.cartItemId);
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

  RemoveCartItemRepo removeCartItemRepo = RemoveCartItemRepo();
  ///////////////////////////////
  Future<void> removeFromCart(pType, puId, sId, index, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    removeCartItemRepo
        .removeCartItem(
            RemoveItemFromCartReq(
                productType: pType.toString(),
                productUnitId: puId.toString(),
                shopId: sId.toString(),
                quantity: "0"),
            pref.getString("successToken"))
        .then((response) async {
      log("response.body${response.body}");
      final result =
          CartRemoveResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        isCategoryProductAdded[index] = false;
        notifyListeners();
        // await getAllOfferes(context, sId);
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

  quantityBtnPressed(value) {
    isQuanityBtnPressed = value;
    notifyListeners();
  }
  CartItemQuantityReqModel get cartItemQuantityRequestModel =>
      CartItemQuantityReqModel(
          cartItemId: cartItemId,
          quantityAction: quantityAction,
          productType: productType,
          shopId: shopId);

  Future<void> subtractItemQuantity(
      context, CIId, index, pType, pUnitId) async {
    quantityBtnPressed(true);
    print("*********");
    print(quantityList);
    print(quantityList[index]);
    print("*********");
    quantityAction = "subtract";
    productType=pType;
    print(cartItemIdList);
    cartItemId = cartItemIdList[index].toString();
    print(cartItemId);
    SharedPreferences pref = await SharedPreferences.getInstance();
    cartItemQuantityRepo
        .cartItemQuantity(
        cartItemQuantityRequestModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = CartItemQuantityResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if (result.status == 200) {
          int value = quantityList[index];
          quantityList.removeAt(index);
          print("${value}valueeeeeeeee");
          quantityList.insert(index, value - 1);

          if (quantityList[index] == 0) {
            removeFromCart(pType, pUnitId,shopId, index, context);
          }
          quantityBtnPressed(false);
          notifyListeners();
        } else {
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
          quantityBtnPressed(false);
        }
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
        quantityBtnPressed(false);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
      quantityBtnPressed(false);
    }).catchError(
          (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        quantityBtnPressed(false);
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }

  Future<void> addItemQuantity(context, CIId,pType,index) async {
    quantityBtnPressed(true);
    quantityAction = "add";
    cartItemId = cartItemIdList[index].toString();
    productType=pType;
    SharedPreferences pref = await SharedPreferences.getInstance();
    cartItemQuantityRepo
        .cartItemQuantity(
        cartItemQuantityRequestModel, pref.getString("successToken"))
        .then((response) {
      print("hello");
      log("response.body${response.body}");
      final result =
      CartItemQuantityResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if (result.status == 200) {
          int value = quantityList[index];
          quantityList.removeAt(index);
          quantityList.insert(index, value + 1);
          quantityBtnPressed(false);

          notifyListeners();
        } else {
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
          quantityBtnPressed(false);
        }
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
        quantityBtnPressed(false);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
      quantityBtnPressed(false);
    }).catchError(
          (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        quantityBtnPressed(false);
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }

}
