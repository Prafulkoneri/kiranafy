// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/cupertino.dart';
// import 'package:local_supper_market/screen/customer/cart/model/add_product_to_cart_model.dart';
// import 'package:local_supper_market/screen/customer/cart/model/cart_item_quantity_model.dart';
// import 'package:local_supper_market/screen/customer/cart/repository/add_product_to_cart_repo.dart';
// import 'package:local_supper_market/screen/customer/cart/repository/cart_item_quantity_repo.dart';
// import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
// import 'package:local_supper_market/screen/customer/shop_profile/model/remove_item_cart_model.dart';
// import 'package:local_supper_market/screen/customer/shop_profile/model/view_all_seasonal_products_model.dart';
// import 'package:local_supper_market/screen/customer/shop_profile/repository/all_seasonal_repo.dart';
// import 'package:local_supper_market/screen/customer/shop_profile/repository/remove_item_from_cart_repo.dart';
// import 'package:local_supper_market/utils/utils.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ShopAllSeasonalController extends ChangeNotifier {
//   String shopId = "";
//   int offset = 0;
//   bool isLoading = true;
//   bool showPaginationLoader = false;
//   List<bool> isAllSeasonalProductAdded = [];
//   AddProductToCartRepo addProductToCartRepo = AddProductToCartRepo();
//   RemoveCartItemRepo removeCartItemRepo = RemoveCartItemRepo();
//   Data? data;
//   // List<CustomerProductData>? seasonalProduct;
//   List<CustomerProductData> seasonalProduct = [];
//   Future<void> initState(context, id) async {
//     seasonalProduct.clear();
//     offset = 0;
//     // await getShopDetails(context, id);
//     await getAllSeasonalProducts(context, id);
//     notifyListeners();
//   }

//   void showLoader(value) {
//     isLoading = value;
//     notifyListeners();
//   }
//   //////All Offer Products

//   ///////////////Seasonal Products/////////
//   AllSeasonalProductsReqModel get shopAllSeasonalReqModel =>
//       AllSeasonalProductsReqModel(
//           offset: offset.toString(), limit: "10", shopId: shopId);
//   AllSeasonalProductsRepo allSeasonalProductsRepo = AllSeasonalProductsRepo();

//   Future<void> getAllSeasonalProducts(context, id) async {
//     if (offset == 0) {
//       isLoading = true;
//     }
//     showPaginationLoader = true;
//     showLoader(true);
//     shopId = id;

//     SharedPreferences pref = await SharedPreferences.getInstance();
//     allSeasonalProductsRepo
//         .getAllSeasonalProducts(
//             shopAllSeasonalReqModel, pref.getString("successToken"))
//         .then((response) {
//       log(response.body);
//       final result =
//           ViewAllSeasonalProducts.fromJson(jsonDecode(response.body));
//       if (response.statusCode == 200) {
//         data = result.data;
//         seasonalProduct.clear();
//         // seasonalProduct = data?.seasonalProducts;
//         seasonalProduct.addAll(result.data?.seasonalProducts ?? []);
//         int seasonProductLength = seasonalProduct?.length ?? 0;
//         isAllSeasonalProductAdded =
//             List<bool>.filled(seasonProductLength, false, growable: true);
//         for (int i = 0; i < seasonProductLength; i++) {
//           if (seasonalProduct?[i].addToCartCheck == "yes") {
//             isAllSeasonalProductAdded.insert(i, true);
//           } else {
//             isAllSeasonalProductAdded.insert(i, false);
//           }
//         }
//         showLoader(false);

//         showPaginationLoader = false;
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

//   //////////////////
//   void onSeasonalSelected(index) {
//     isAllSeasonalProductAdded[index] = true;
//     notifyListeners();
//   }

//   Future<void> addToCart(pType, pId, sId, index, context) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     if (pref.getString("status") == "guestLoggedIn") {
//       Utils().showLoginDialog(context, "Please Login to add product to cart");
//       return;
//     }
//     addProductToCartRepo
//         .addProductToCart(
//             AddProductToCartReqModel(
//                 productType: pType,
//                 productUnitId: pId.toString(),
//                 shopId: sId.toString(),
//                 quantity: "1"),
//             pref.getString("successToken"))
//         .then((response) {
//       log("response.body${response.body}");
//       final result =
//           AddProductToCartResModel.fromJson(jsonDecode(response.body));
//       if (response.statusCode == 200) {
//         isAllSeasonalProductAdded[index] = true;
//         Utils.showPrimarySnackbar(context, result.message,
//             type: SnackType.success);
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

//   Future<void> onScrollMaxExtent(context, id) async {
//     print("hello");
//     offset = offset + 1;
//     showPaginationLoader = true;
//     showLoader(true);
//     shopId = id;

//     SharedPreferences pref = await SharedPreferences.getInstance();
//     allSeasonalProductsRepo
//         .getAllSeasonalProducts(
//             shopAllSeasonalReqModel, pref.getString("successToken"))
//         .then((response) {
//       log(response.body);
//       final result =
//           ViewAllSeasonalProducts.fromJson(jsonDecode(response.body));
//       if (response.statusCode == 200) {
//         data = result.data;
//         // seasonalProduct.clear();
//         // seasonalProduct = data?.seasonalProducts;
//         seasonalProduct.addAll(result.data?.seasonalProducts ?? []);
//         int seasonProductLength = seasonalProduct?.length ?? 0;
//         isAllSeasonalProductAdded =
//             List<bool>.filled(seasonProductLength, false, growable: true);
//         for (int i = 0; i < seasonProductLength; i++) {
//           if (seasonalProduct?[i].addToCartCheck == "yes") {
//             isAllSeasonalProductAdded.insert(i, true);
//           } else {
//             isAllSeasonalProductAdded.insert(i, false);
//           }
//         }
//         showLoader(false);

//         showPaginationLoader = false;
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
//     // await getAllSeasonalProducts(context, id);
//     isLoading = false;

//     notifyListeners();
//   }

//   ////////////////////////////////////////////////////////

//   Future<void> removeFromCart(pType, puId, sId, index, context) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     removeCartItemRepo
//         .removeCartItem(
//             RemoveItemFromCartReq(
//                 productType: pType.toString(),
//                 productUnitId: puId.toString(),
//                 shopId: sId.toString(),
//                 quantity: "0"),
//             pref.getString("successToken"))
//         .then((response) async {
//       log("response.body${response.body}");
//       final result =
//           CartRemoveResponseModel.fromJson(jsonDecode(response.body));
//       if (response.statusCode == 200) {
//         isAllSeasonalProductAdded[index] = false;
//         // await getAllOfferes(context, sId);
//         Utils.showPrimarySnackbar(context, result.message,
//             type: SnackType.success);
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

//   quantityBtnPressed(value) {
//     isQuanityBtnPressed = value;
//     notifyListeners();
//   }

//   CartItemQuantityReqModel get cartItemQuantityRequestModel =>
//       CartItemQuantityReqModel(
//           cartItemId: cartItemId,
//           quantityAction: quantityAction,
//           productType: productType,
//           shopId: shopId);

//   Future<void> subtractItemQuantity(
//       context, CIId, index, pType, pUnitId) async {
//     quantityBtnPressed(true);
//     print("*********");
//     print(quantityList);
//     print(quantityList[index]);
//     print("*********");
//     quantityAction = "subtract";
//     productType = pType;
//     print(cartItemIdList);
//     cartItemId = cartItemIdList[index].toString();
//     print(cartItemId);
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     cartItemQuantityRepo
//         .cartItemQuantity(
//             cartItemQuantityRequestModel, pref.getString("successToken"))
//         .then((response) {
//       log("response.body${response.body}");
//       final result =
//           CartItemQuantityResponseModel.fromJson(jsonDecode(response.body));
//       if (response.statusCode == 200) {
//         if (result.status == 200) {
//           int value = quantityList[index];
//           quantityList.removeAt(index);
//           print("${value}valueeeeeeeee");
//           quantityList.insert(index, value - 1);

//           if (quantityList[index] == 0) {
//             removeFromCart(pType, pUnitId, shopId, index, context);
//           }
//           quantityBtnPressed(false);
//           notifyListeners();
//         } else {
//           Utils.showPrimarySnackbar(context, result.message,
//               type: SnackType.error);
//           quantityBtnPressed(false);
//         }
//       } else {
//         Utils.showPrimarySnackbar(context, result.message,
//             type: SnackType.error);
//         quantityBtnPressed(false);
//       }
//     }).onError((error, stackTrace) {
//       Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
//       quantityBtnPressed(false);
//     }).catchError(
//       (Object e) {
//         Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
//         quantityBtnPressed(false);
//       },
//       test: (Object e) {
//         Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
//         return false;
//       },
//     );
//   }

//   String quantityAction = "";
//   // List<bool> isCategoryProductAdded = [];
//   List cartItemIdList = [];
//   List quantityList = [];
//   bool isQuanityBtnPressed = false;
//   String cartItemId = "";
//   String productType = "";
//   CartItemQuantityRepo cartItemQuantityRepo = CartItemQuantityRepo();
//   Future<void> addItemQuantity(context, CIId, pType, index) async {
//     quantityBtnPressed(true);
//     quantityAction = "add";
//     cartItemId = cartItemIdList[index].toString();
//     productType = pType;
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     cartItemQuantityRepo
//         .cartItemQuantity(
//             cartItemQuantityRequestModel, pref.getString("successToken"))
//         .then((response) {
//       print("hello");
//       log("response.body${response.body}");
//       final result =
//           CartItemQuantityResponseModel.fromJson(jsonDecode(response.body));
//       if (response.statusCode == 200) {
//         if (result.status == 200) {
//           int value = quantityList[index];
//           quantityList.removeAt(index);
//           quantityList.insert(index, value + 1);
//           quantityBtnPressed(false);

//           notifyListeners();
//         } else {
//           Utils.showPrimarySnackbar(context, result.message,
//               type: SnackType.error);
//           quantityBtnPressed(false);
//         }
//       } else {
//         Utils.showPrimarySnackbar(context, result.message,
//             type: SnackType.error);
//         quantityBtnPressed(false);
//       }
//     }).onError((error, stackTrace) {
//       Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
//       quantityBtnPressed(false);
//     }).catchError(
//       (Object e) {
//         Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
//         quantityBtnPressed(false);
//       },
//       test: (Object e) {
//         Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
//         return false;
//       },
//     );
//   }
// }
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:local_supper_market/screen/customer/cart/model/add_product_to_cart_model.dart';
import 'package:local_supper_market/screen/customer/cart/model/cart_item_quantity_model.dart';
import 'package:local_supper_market/screen/customer/cart/repository/add_product_to_cart_repo.dart';
import 'package:local_supper_market/screen/customer/cart/repository/cart_item_quantity_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/remove_item_cart_model.dart';

// import 'package:local_supper_market/screen/customer/shop_profile/model/view_all_offer_products.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/view_all_seasonal_products_model.dart';

import 'package:local_supper_market/screen/customer/shop_profile/repository/all_seasonal_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/repository/remove_item_from_cart_repo.dart';

import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopAllSeasonalController extends ChangeNotifier {
  String shopId = "";
  int offset = 0;
  bool isLoading = true;
  bool showPaginationLoader = false;
  List<bool> isAllSeasonalProductAdded = [];
  AddProductToCartRepo addProductToCartRepo = AddProductToCartRepo();
  RemoveCartItemRepo removeCartItemRepo = RemoveCartItemRepo();
  Data? data;
  // List<CustomerProductData>? seasonalProduct;
  List<CustomerProductData> seasonalProduct = [];
  Future<void> initState(context, id) async {
    seasonalProduct.clear();
    offset = 0;
    // await getShopDetails(context, id);
    await getAllSeasonalProducts(context, id);
    notifyListeners();
  }

  void showLoader(value) {
    isLoading = value;
    notifyListeners();
  }
  //////All Offer Products

  ///////////////Seasonal Products/////////
  AllSeasonalProductsReqModel get shopAllSeasonalReqModel =>
      AllSeasonalProductsReqModel(
          offset: offset.toString(), limit: "10", shopId: shopId);
  AllSeasonalProductsRepo allSeasonalProductsRepo = AllSeasonalProductsRepo();

  Future<void> getAllSeasonalProducts(context, id) async {
    if (offset == 0) {
      isLoading = true;
    }
    showPaginationLoader = true;
    showLoader(true);
    shopId = id;

    SharedPreferences pref = await SharedPreferences.getInstance();
    allSeasonalProductsRepo
        .getAllSeasonalProducts(
            shopAllSeasonalReqModel, pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result =
          ViewAllSeasonalProducts.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        data = result.data;
        seasonalProduct.clear();
        // seasonalProduct = data?.seasonalProducts;
        seasonalProduct.addAll(result.data?.seasonalProducts ?? []);
        int seasonProductLength = seasonalProduct?.length ?? 0;
        isAllSeasonalProductAdded =
            List<bool>.filled(seasonProductLength, false, growable: true);
        for (int i = 0; i < seasonProductLength; i++) {
          if (seasonalProduct?[i].addToCartCheck == "yes") {
            isAllSeasonalProductAdded.insert(i, true);
          } else {
            isAllSeasonalProductAdded.insert(i, false);
          }
        }
        showLoader(false);

        showPaginationLoader = false;
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

  //////////////////
  void onSeasonalSelected(index) {
    isAllSeasonalProductAdded[index] = true;
    notifyListeners();
  }

  // Future<void> addToCart(pType, pId, sId, index, context) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   if (pref.getString("status") == "guestLoggedIn") {
  //     Utils().showLoginDialog(context, "Please Login to add product to cart");
  //     return;
  //   }
  //   addProductToCartRepo
  //       .addProductToCart(
  //           AddProductToCartReqModel(
  //               productType: pType,
  //               productUnitId: pId.toString(),
  //               shopId: sId.toString(),
  //               quantity: "1"),
  //           pref.getString("successToken"))
  //       .then((response) {
  //     log("response.body${response.body}");
  //     final result =
  //         AddProductToCartResModel.fromJson(jsonDecode(response.body));
  //     if (response.statusCode == 200) {
  //       isAllSeasonalProductAdded[index] = true;
  //       Utils.showPrimarySnackbar(context, result.message,
  //           type: SnackType.success);
  //       notifyListeners();
  //     } else {
  //       Utils.showPrimarySnackbar(context, result.message,
  //           type: SnackType.error);
  //     }
  //   }).onError((error, stackTrace) {
  //     Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
  //   }).catchError(
  //     (Object e) {
  //       Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
  //     },
  //     test: (Object e) {
  //       Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
  //       return false;
  //     },
  //   );
  // }
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
        isAllSeasonalProductAdded[index] = true;
        quantitySeasonalList.removeAt(index);
        quantitySeasonalList.insert(index, 1);
        cartItemIdList.removeAt(index);
        cartItemIdList.insert(index, result.cartItemId);
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

  Future<void> onScrollMaxExtent(context, id) async {
    print("hello");
    offset = offset + 1;
    showPaginationLoader = true;
    showLoader(true);
    shopId = id;

    SharedPreferences pref = await SharedPreferences.getInstance();
    allSeasonalProductsRepo
        .getAllSeasonalProducts(
            shopAllSeasonalReqModel, pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result =
          ViewAllSeasonalProducts.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        data = result.data;
        // seasonalProduct.clear();
        // seasonalProduct = data?.seasonalProducts;
        seasonalProduct.addAll(result.data?.seasonalProducts ?? []);
        int seasonProductLength = seasonalProduct?.length ?? 0;
        isAllSeasonalProductAdded =
            List<bool>.filled(seasonProductLength, false, growable: true);
        for (int i = 0; i < seasonProductLength; i++) {
          if (seasonalProduct?[i].addToCartCheck == "yes") {
            isAllSeasonalProductAdded.insert(i, true);
          } else {
            isAllSeasonalProductAdded.insert(i, false);
          }
        }
        showLoader(false);

        showPaginationLoader = false;
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
    // await getAllSeasonalProducts(context, id);
    isLoading = false;

    notifyListeners();
  }

  ////////////////////////////////////////////////////////

  // Future<void> removeFromCart(pType, puId, sId, index, context) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   removeCartItemRepo
  //       .removeCartItem(
  //           RemoveItemFromCartReq(
  //               productType: pType.toString(),
  //               productUnitId: puId.toString(),
  //               shopId: sId.toString(),
  //               quantity: "0"),
  //           pref.getString("successToken"))
  //       .then((response) async {
  //     log("response.body${response.body}");
  //     final result =
  //         CartRemoveResponseModel.fromJson(jsonDecode(response.body));
  //     if (response.statusCode == 200) {
  //       isAllSeasonalProductAdded[index] = false;
  //       // await getAllOfferes(context, sId);
  //       Utils.showPrimarySnackbar(context, result.message,
  //           type: SnackType.success);
  //       notifyListeners();
  //     } else {
  //       Utils.showPrimarySnackbar(context, result.message,
  //           type: SnackType.error);
  //     }
  //   }).onError((error, stackTrace) {
  //     Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
  //   }).catchError(
  //     (Object e) {
  //       Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
  //     },
  //     test: (Object e) {
  //       Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
  //       return false;
  //     },
  //   );
  // }
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
        isAllSeasonalProductAdded[index] = false;
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

  CartItemQuantityRepo cartItemQuantityRepo = CartItemQuantityRepo();
  String quantityAction = "";
  List<bool> isSeasonalProductAdded = [];
  List cartItemIdList = [];
  List quantitySeasonalList = [];
  bool isQuanityBtnPressed = false;
  String cartItemId = "";
  String productType = "";
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
    print(quantitySeasonalList);
    print(quantitySeasonalList[index]);
    print("*********");
    quantityAction = "subtract";
    productType = pType;
    print(cartItemIdList);
    cartItemId = cartItemIdList[index].toString();
    print(cartItemId);
    SharedPreferences pref = await SharedPreferences.getInstance();
    cartItemQuantityRepo
        .cartItemQuantity(
            cartItemQuantityRequestModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result =
          CartItemQuantityResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if (result.status == 200) {
          int value = quantitySeasonalList[index];
          quantitySeasonalList.removeAt(index);
          print("${value}valueeeeeeeee");
          quantitySeasonalList.insert(index, value - 1);

          if (quantitySeasonalList[index] == 0) {
            removeFromCart(pType, pUnitId, shopId, index, context);
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

  Future<void> addItemQuantity(context, CIId, pType, index) async {
    quantityBtnPressed(true);
    quantityAction = "add";
    cartItemId = cartItemIdList[index].toString();
    productType = pType;
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
          int value = quantitySeasonalList[index];
          quantitySeasonalList.removeAt(index);
          quantitySeasonalList.insert(index, value + 1);
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
