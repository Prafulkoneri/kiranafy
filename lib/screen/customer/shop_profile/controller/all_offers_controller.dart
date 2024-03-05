// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/cupertino.dart';
// import 'package:local_supper_market/screen/customer/cart/model/add_product_to_cart_model.dart';
// import 'package:local_supper_market/screen/customer/cart/repository/add_product_to_cart_repo.dart';
// import 'package:local_supper_market/screen/customer/near_shops/model/add_fav_model.dart';
// import 'package:local_supper_market/screen/customer/near_shops/model/remove_fav_shop_model.dart';
// import 'package:local_supper_market/screen/customer/near_shops/repository/add_fav_shop_repo.dart';
// import 'package:local_supper_market/screen/customer/near_shops/repository/remove_fav_shop_repo.dart';
// import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
// import 'package:local_supper_market/screen/customer/shop_profile/model/remove_item_cart_model.dart';
// import 'package:local_supper_market/screen/customer/shop_profile/model/view_all_offer_products_model.dart';

// import 'package:local_supper_market/screen/customer/shop_profile/repository/all_products_repo.dart';
// import 'package:local_supper_market/screen/customer/shop_profile/repository/customer_view_shop_repo.dart';
// import 'package:local_supper_market/screen/customer/shop_profile/repository/remove_item_from_cart_repo.dart';
// import 'package:local_supper_market/utils/utils.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';

// class AllOffersController extends ChangeNotifier {
//   String shopId = "";
//   int offset = 0;
//   bool isLoading = true;
//   Data? allproducts;
//   AllOfferProductsRepo allOfferProductsRepo = AllOfferProductsRepo();
//   AddProductToCartRepo addProductToCartRepo = AddProductToCartRepo();
//   List<ShopCategory>? shopCategory;
//   List<CustomerProductData>? offerProduct;
//   List<CustomerProductData> allOfferProducts = [];
//   bool showPaginationLoader = false;
//   List<bool> isAllOfferProductAdded = [];
//   bool favAllShop = true; /////shop add fvrt
//   AddFavShopRepo addFavShopRepo = AddFavShopRepo();
//   RemoveCartItemRepo removeCartItemRepo = RemoveCartItemRepo();
//   Future<void> initState(context, id) async {
//     allOfferProducts.clear();
//     offset = 0;
//     await getAllOfferes(context, id);
//     notifyListeners();
//   }

//   void showLoader(value) {
//     isLoading = value;
//     notifyListeners();
//   }

//   //////All Offer Products
//   AllProductsReqModel get shopAllProductsReqModel => AllProductsReqModel(
//       offset: offset.toString(), limit: "10", shopId: shopId);

//   Future<void> getAllOfferes(context, id) async {
//     if (offset == 0) {
//       isLoading = true;
//     }
//     showPaginationLoader = true;
//     shopId = id;
//     showLoader(true);
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     allOfferProductsRepo
//         .getAllOffereProducts(
//             shopAllProductsReqModel, pref.getString("successToken"))
//         .then((response) {
//       log(response.body);
//       final result = ViewAllOfferProducts.fromJson(jsonDecode(response.body));
//       if (response.statusCode == 200) {
//         allOfferProducts.clear();
//         allproducts = result.data;
//         // allOfferProducts = allproducts?.offerProducts;
//         allOfferProducts.addAll(result.data?.offerProducts ?? []);
//         isAllOfferProductAdded =
//             List<bool>.filled(allOfferProducts.length, false, growable: true);
//         for (int i = 0; i < allOfferProducts.length; i++) {
//           if (allOfferProducts[i].addToCartCheck == "yes") {
//             isAllOfferProductAdded.insert(i, true);
//           } else {
//             isAllOfferProductAdded.insert(i, false);
//           }
//         }
//         //   int seasonProductLength = seasonalProduct?.length ?? 0;
//         // isAllSeasonalProductAdded =
//         //     List<bool>.filled(seasonProductLength, false, growable: true);
//         // for (int i = 0; i < seasonProductLength; i++) {
//         //   if (seasonalProduct?[i].addToCartCheck == "yes") {
//         //     isAllSeasonalProductAdded.insert(i, true);
//         //   } else {
//         //     isAllSeasonalProductAdded.insert(i, false);
//         //   }
//         // }
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

//   RemoveFavReqModel get removeFavReqModel => RemoveFavReqModel(
//         shopId: shopId.toString(),
//       );
//   RemoveFavShopRepo removeFavShopRepo = RemoveFavShopRepo();
//   Future<void> removeAllShopFavList(context, id) async {
//     shopId = id.toString();
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     removeFavShopRepo
//         .updateRemoveFavShop(removeFavReqModel, pref.getString("successToken"))
//         .then((response) {
//       log("response.body${response.body}");
//       final result = RemoveFavResModel.fromJson(jsonDecode(response.body));
//       if (response.statusCode == 200) {
//         favAllShop = false;
//         print("hello");
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

//   void onOfferProductSelected(index) {
//     isAllOfferProductAdded[index] = true;
//     notifyListeners();
//   }
//   //////////////////

// ///////////////////Update List
//   AddFavReqModel get addFavReqModel => AddFavReqModel(
//         shopId: shopId.toString(),
//       );
//   Future<void> updateAllShopFavList(context, id) async {
//     shopId = id.toString();
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     print(pref.getString("successToken"));
//     addFavShopRepo
//         .updateAddFavShop(addFavReqModel, pref.getString("successToken"))
//         .then((response) {
//       log("response.body${response.body}");
//       final result = AddFavResModel.fromJson(jsonDecode(response.body));
//       if (response.statusCode == 200) {
//         favAllShop = true;
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

//   Future<void> addToCart(pType, pId, sId, index, context) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
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
//         isAllOfferProductAdded[index] = true;
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
//     shopId = id;
//     showLoader(true);
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     allOfferProductsRepo
//         .getAllOffereProducts(
//             shopAllProductsReqModel, pref.getString("successToken"))
//         .then((response) {
//       log(response.body);
//       final result = ViewAllOfferProducts.fromJson(jsonDecode(response.body));
//       if (response.statusCode == 200) {
//         // allOfferProducts.clear();
//         allproducts = result.data;
//         // allOfferProducts = allproducts?.offerProducts;
//         allOfferProducts.addAll(result.data?.offerProducts ?? []);
//         // int seasonProductLength = seasonalProduct?.length ?? 0;
//         isAllOfferProductAdded =
//             List<bool>.filled(allOfferProducts.length, false, growable: true);
//         for (int i = 0; i < allOfferProducts.length; i++) {
//           if (allOfferProducts[i].addToCartCheck == "yes") {
//             isAllOfferProductAdded.insert(i, true);
//           } else {
//             isAllOfferProductAdded.insert(i, false);
//           }
//         }
//         //   int seasonProductLength = seasonalProduct?.length ?? 0;
//         // isAllSeasonalProductAdded =
//         //     List<bool>.filled(seasonProductLength, false, growable: true);
//         // for (int i = 0; i < seasonProductLength; i++) {
//         //   if (seasonalProduct?[i].addToCartCheck == "yes") {
//         //     isAllSeasonalProductAdded.insert(i, true);
//         //   } else {
//         //     isAllSeasonalProductAdded.insert(i, false);
//         //   }
//         // }
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
//     await getAllOfferes(context, id);
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
//         isAllOfferProductAdded[index] = false;
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
// }
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:local_supper_market/screen/customer/cart/model/add_product_to_cart_model.dart';
import 'package:local_supper_market/screen/customer/cart/model/cart_item_quantity_model.dart';
import 'package:local_supper_market/screen/customer/cart/repository/add_product_to_cart_repo.dart';
import 'package:local_supper_market/screen/customer/cart/repository/cart_item_quantity_repo.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/add_fav_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/remove_fav_shop_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/add_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/remove_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/remove_item_cart_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/view_all_offer_products_model.dart';

import 'package:local_supper_market/screen/customer/shop_profile/repository/all_products_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/repository/remove_item_from_cart_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllOffersController extends ChangeNotifier {
  String shopId = "";
  int offset = 0;
  bool isLoading = true;
  Data? allproducts;
  AllOfferProductsRepo allOfferProductsRepo = AllOfferProductsRepo();
  AddProductToCartRepo addProductToCartRepo = AddProductToCartRepo();
  List<ShopCategory>? shopCategory;
  // List<CustomerProductData>? offerProduct;
  List<CustomerProductData> allOfferProducts = [];
  //  List<CustomerProductData> seasonalProduct = [];
  bool showPaginationLoader = false;
  List<bool> isAllOfferProductAdded = [];
  bool favAllShop = true; /////shop add fvrt
  AddFavShopRepo addFavShopRepo = AddFavShopRepo();
  RemoveCartItemRepo removeCartItemRepo = RemoveCartItemRepo();

  bool isQuanityBtnPressed = false;
  // List cartItemIdList = [];
  List cartItemIdList = [];
  List quantityList = [];
  String quantityAction = "";
  String cartItemId = "";
  String productType = "";
  CartItemQuantityRepo cartItemQuantityRepo = CartItemQuantityRepo();
  Future<void> initState(context, id) async {
    quantityList.clear();
    cartItemIdList.clear();
    allOfferProducts.clear();
    offset = 0;
    await getAllOfferes(context, id);
    notifyListeners();
  }

  void showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  //////All Offer Products
  AllProductsReqModel get shopAllProductsReqModel => AllProductsReqModel(
      offset: offset.toString(), limit: "10", shopId: shopId);

  // Future<void> getAllOfferes(context, id) async {
  //   if (offset == 0) {
  //     isLoading = true;
  //   }
  //   showPaginationLoader = true;
  //   shopId = id;
  //   showLoader(true);
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   allOfferProductsRepo
  //       .getAllOffereProducts(
  //           shopAllProductsReqModel, pref.getString("successToken"))
  //       .then((response) {
  //     log(response.body);
  //     final result = ViewAllOfferProducts.fromJson(jsonDecode(response.body));
  //     if (response.statusCode == 200) {
  //       allOfferProducts.clear();
  //       allproducts = result.data;
  //       // allOfferProducts = allproducts?.offerProducts;
  //       allOfferProducts.addAll(result.data?.offerProducts ?? []);
  //       isAllOfferProductAdded =
  //           List<bool>.filled(allOfferProducts.length, false, growable: true);
  //       for (int i = 0; i < allOfferProducts.length; i++) {
  //         if (allOfferProducts[i].addToCartCheck == "yes") {
  //           isAllOfferProductAdded.insert(i, true);
  //         } else {
  //           isAllOfferProductAdded.insert(i, false);
  //         }
  //       }
  //       //   int seasonProductLength = seasonalProduct?.length ?? 0;
  //       // isAllSeasonalProductAdded =
  //       //     List<bool>.filled(seasonProductLength, false, growable: true);
  //       // for (int i = 0; i < seasonProductLength; i++) {
  //       //   if (seasonalProduct?[i].addToCartCheck == "yes") {
  //       //     isAllSeasonalProductAdded.insert(i, true);
  //       //   } else {
  //       //     isAllSeasonalProductAdded.insert(i, false);
  //       //   }
  //       // }
  //       showLoader(false);
  //       showPaginationLoader = false;
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
///////////////////////////////////

  Future<void> getAllOfferes(context, id) async {
    if (offset == 0) {
      isLoading = true;
    }
    showPaginationLoader = true;
    showLoader(true);
    shopId = id;

    SharedPreferences pref = await SharedPreferences.getInstance();
    allOfferProductsRepo
        .getAllOffereProducts(
            shopAllProductsReqModel, pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result = ViewAllOfferProducts.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        allproducts = result.data;
        allOfferProducts.clear();
        // seasonalProduct = data?.seasonalProducts;
        allOfferProducts.addAll(result.data?.offerProducts ?? []);
        int offerProductLength = allOfferProducts.length ?? 0;
        isAllOfferProductAdded =
            List<bool>.filled(offerProductLength, false, growable: true);
        for (int i = 0; i < offerProductLength; i++) {
          if (allOfferProducts[i].addToCartCheck == "yes") {
            isAllOfferProductAdded.insert(i, true);
          } else {
            isAllOfferProductAdded.insert(i, false);
          }
        }
        ///////////////
        for (int i = 0; i < offerProductLength; i++) {
          quantityList.add(allOfferProducts[i].quantity);
          cartItemIdList.add(allOfferProducts[i].cartItemId);
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

  //////////////////////////
  RemoveFavReqModel get removeFavReqModel => RemoveFavReqModel(
        shopId: shopId.toString(),
      );
  RemoveFavShopRepo removeFavShopRepo = RemoveFavShopRepo();
  Future<void> removeAllShopFavList(context, id) async {
    shopId = id.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    removeFavShopRepo
        .updateRemoveFavShop(removeFavReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = RemoveFavResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        favAllShop = false;
        print("hello");
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

  void onOfferProductSelected(index) {
    isAllOfferProductAdded[index] = true;
    notifyListeners();
  }
  //////////////////

///////////////////Update List
  AddFavReqModel get addFavReqModel => AddFavReqModel(
        shopId: shopId.toString(),
      );
  Future<void> updateAllShopFavList(context, id) async {
    shopId = id.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    addFavShopRepo
        .updateAddFavShop(addFavReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = AddFavResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        favAllShop = true;
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

  Future<void> addToCart(pType, pId, sId, index, context) async {
    print("index:$index");
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
        final readMain =
            Provider.of<MainScreenController>(context, listen: false);
        readMain.getCartCount(result.cartCount);
        isAllOfferProductAdded[index] = true;
        quantityList.removeAt(index);
        quantityList.insert(index, 1);
        print(quantityList);
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

  // Future<void> onScrollMaxExtent(context, id) async {
  //   print("hello");
  //   offset = offset + 1;
  //   showPaginationLoader = true;
  //   shopId = id;
  //   showLoader(true);
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   allOfferProductsRepo
  //       .getAllOffereProducts(
  //           shopAllProductsReqModel, pref.getString("successToken"))
  //       .then((response) {
  //     log(response.body);
  //     final result = ViewAllOfferProducts.fromJson(jsonDecode(response.body));
  //     if (response.statusCode == 200) {
  //       // allOfferProducts.clear();
  //       allproducts = result.data;
  //       // allOfferProducts = allproducts?.offerProducts;
  //       allOfferProducts.addAll(result.data?.offerProducts ?? []);
  //       // int seasonProductLength = seasonalProduct?.length ?? 0;
  //       isAllOfferProductAdded =
  //           List<bool>.filled(allOfferProducts.length, false, growable: true);
  //       for (int i = 0; i < allOfferProducts.length; i++) {
  //         if (allOfferProducts[i].addToCartCheck == "yes") {
  //           isAllOfferProductAdded.insert(i, true);
  //         } else {
  //           isAllOfferProductAdded.insert(i, false);
  //         }
  //       }
  //       //   int seasonProductLength = seasonalProduct?.length ?? 0;
  //       // isAllSeasonalProductAdded =
  //       //     List<bool>.filled(seasonProductLength, false, growable: true);
  //       // for (int i = 0; i < seasonProductLength; i++) {
  //       //   if (seasonalProduct?[i].addToCartCheck == "yes") {
  //       //     isAllSeasonalProductAdded.insert(i, true);
  //       //   } else {
  //       //     isAllSeasonalProductAdded.insert(i, false);
  //       //   }
  //       // }
  //       showLoader(false);
  //       showPaginationLoader = false;
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
  //   await getAllOfferes(context, id);
  //   isLoading = false;
  //   notifyListeners();
  // }

  Future<void> onScrollMaxExtent(context, id) async {
    print("hello");
    offset = offset + 1;
    showPaginationLoader = true;
    showLoader(true);
    shopId = id;

    SharedPreferences pref = await SharedPreferences.getInstance();
    allOfferProductsRepo
        .getAllOffereProducts(
            shopAllProductsReqModel, pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result = ViewAllOfferProducts.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        allproducts = result.data;

        allOfferProducts.addAll(result.data?.offerProducts ?? []);
        int offerProductLength = allOfferProducts.length ?? 0;
        isAllOfferProductAdded =
            List<bool>.filled(offerProductLength, false, growable: true);
        for (int i = 0; i < offerProductLength; i++) {
          if (allOfferProducts[i].addToCartCheck == "yes") {
            isAllOfferProductAdded.insert(i, true);
          } else {
            isAllOfferProductAdded.insert(i, false);
          }
        }
        int length = result.data?.offerProducts?.length ?? 0;
        for (int i = 0; i < length; i++) {
          quantityList.add(result.data?.offerProducts?[i].quantity);
          cartItemIdList.add(result.data?.offerProducts?[i].cartItemId);
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
        final readMain =
            Provider.of<MainScreenController>(context, listen: false);
        readMain.getCartCount(result.cartCount);
        isAllOfferProductAdded[index] = false;
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
          int value = quantityList[index];
          quantityList.removeAt(index);
          print("${value}valueeeeeeeee");
          quantityList.insert(index, value - 1);

          if (quantityList[index] == 0) {
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
