import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/cart/model/add_product_to_cart_model.dart';
import 'package:local_supper_market/screen/customer/cart/model/cart_item_quantity_model.dart';
import 'package:local_supper_market/screen/customer/cart/repository/add_product_to_cart_repo.dart';
import 'package:local_supper_market/screen/customer/cart/repository/cart_item_quantity_repo.dart';
import 'package:local_supper_market/screen/customer/home/view/home_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/add_fav_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/remove_fav_shop_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/add_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/remove_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/view/all_near_shops_category_view.dart';
import 'package:local_supper_market/screen/customer/near_shops/view/all_near_shops_view.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/remove_item_cart_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/shop_coupons_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/view_all_offer_products_model.dart';

import 'package:local_supper_market/screen/customer/shop_profile/repository/all_products_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/repository/customer_view_shop_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/repository/remove_item_from_cart_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/repository/shop_profile_coupons_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/model/dash_board_model.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopProfileViewController extends ChangeNotifier {
  String shopId = "";
  String productType = "";
  String productUnitId = "";
  String quantity = "";
  int offset = 0;
  bool isLoading = true;
  PageController pageController = PageController();
  // Data? allproducts;
  CustomerViewShopRepo customerViewShopRepo = CustomerViewShopRepo();
  AllOfferProductsRepo allOfferProductsRepo = AllOfferProductsRepo();
  ShopViewData? shopData;
  ShopDetails? shopDetails;
  List<ShopCategory>? shopCategory;
  List<CustomerProductData>? offerProduct;
  List<CustomerProductData>? allOfferProducts;
  List<CustomerProductData>? seasonalProduct;
  List<CustomerProductData>? recommandedProduct;
  List<BannerImageData>? bannerImageData;
  List<ShopCouponsList>? shopCouponsList;
  SProfileCouponData? sprofilecoupondata;
  int _currentPage = 0;
  bool? deliveryAddressStatus;
  List<bool> isSeasonalProductAdded = [];
  List<bool> isRecommendedProductAdded = [];
  List<bool> isOfferProductAdded = [];

  AddProductToCartRepo addProductToCartRepo = AddProductToCartRepo();
  RemoveCartItemRepo removeCartItemRepo = RemoveCartItemRepo();
  ShopProfileCouponRepo sProfileCouponRepo = ShopProfileCouponRepo();
  bool favAllShop = true; /////shop add fvrt
  AddFavShopRepo addFavShopRepo = AddFavShopRepo();
  bool isPageRefresh = false;

  CartItemQuantityRepo cartItemQuantityRepo = CartItemQuantityRepo();
  String quantityAction = "";

  List cartItemIdSeasonalList = [];
  List cartItemIdRecommandedList = [];
  List cartItemIdOfferlList = [];
  List quantitySeasonalList = [];
  List quantityRecommandedList = [];
  List quantityOfferList = [];
  bool isQuanityBtnPressed = false;
  String cartItemId = "";

  Future<void> initState(context, id, refresh) async {
    if (refresh) {
      showLoader(true);
      print("kkkkkkkk");
      await getShopDetails(context, id, refresh);
    } else {
      showLoader(false);
    }
  }

  void showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  CustomerViewShopReqModel get customerViewShopReqModel =>
      CustomerViewShopReqModel(
        shopId: shopId,
      );

  void onBackPressed(screenName, context, cId) {
    print(screenName);
  }

  Future<void> getShopDetails(context, id, refresh) async {
    print("id$id");
    shopId = id;
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    customerViewShopRepo
        .getShopDetails(
            customerViewShopReqModel, pref.getString("successToken"))
        .then((response) async {
      log("response.body${response.body}");
      final result =
          CustomerViewShopResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        deliveryAddressStatus = result.deliveryAddressStatus;
        shopData = result.data;
        shopDetails = shopData?.shopDetails;
        shopCategory = shopData?.shopCategories;
        offerProduct = shopData?.offerProduct;
        //for seasonal
        seasonalProduct = shopData?.seasonalProduct;
        int seasonProductLength = seasonalProduct?.length ?? 0;
        isSeasonalProductAdded =
            List<bool>.filled(seasonProductLength, false, growable: true);
        for (int i = 0; i < seasonProductLength; i++) {
          if (seasonalProduct?[i].addToCartCheck == "yes") {
            isSeasonalProductAdded.insert(i, true);
          } else {
            isSeasonalProductAdded.insert(i, false);
          }
        }
        //for recommended
        recommandedProduct = shopData?.recommandedProduct;
        int recommandedProductLength = recommandedProduct?.length ?? 0;
        isRecommendedProductAdded =
            List<bool>.filled(recommandedProductLength, false, growable: true);
        for (int i = 0; i < recommandedProductLength; i++) {
          if (recommandedProduct?[i].addToCartCheck == "yes") {
            isRecommendedProductAdded.insert(i, true);
          } else {
            isRecommendedProductAdded.insert(i, false);
          }
        }
        ////////////////////Offer///////////
        offerProduct = shopData?.offerProduct;
        int offerProductLength = offerProduct?.length ?? 0;
        isOfferProductAdded =
            List<bool>.filled(offerProductLength, false, growable: true);
        for (int i = 0; i < offerProductLength; i++) {
          if (offerProduct?[i].addToCartCheck == "yes") {
            isOfferProductAdded.insert(i, true);
          } else {
            isOfferProductAdded.insert(i, false);
          }
        }
        bannerImageData = shopData?.bannerImages;

        favAllShop = shopDetails?.shopFavourite == "yes" ? true : false;
        print("bye");
        print(favAllShop);
        print("uivynuibnywetinyiqwn8wq7eyvnb8q8ew");
        quantitySeasonalList.clear();
        quantityOfferList.clear();
        quantityRecommandedList.clear();
        cartItemIdRecommandedList.clear();
        cartItemIdOfferlList.clear();
        cartItemIdSeasonalList.clear();
        for (int i = 0; i < seasonProductLength; i++) {
          quantitySeasonalList.add(seasonalProduct?[i].quantity);
          cartItemIdSeasonalList.add(seasonalProduct?[i].cartItemId);
        }
        for (int i = 0; i < recommandedProductLength; i++) {
          quantityRecommandedList.add(recommandedProduct?[i].quantity);
          cartItemIdRecommandedList.add(recommandedProduct?[i].cartItemId);
        }
        for (int i = 0; i < offerProductLength; i++) {
          quantityOfferList.add(offerProduct?[i].quantity);
          cartItemIdOfferlList.add(offerProduct?[i].cartItemId);
        }

        int imageLength = bannerImageData?.length ?? 0;
        if (bannerImageData!.isNotEmpty) {
          Timer.periodic(Duration(seconds: 5), (Timer timer) {
            print(_currentPage);
            if (_currentPage < imageLength - 1) {
              _currentPage++;
              pageController.nextPage(
                // _currentPage,
                duration: Duration(milliseconds: 350),
                curve: Curves.easeIn,
              );
              print("still going");
            } else {
              _currentPage = 0;
              pageController.animateToPage(
                // _currentPage,
                _currentPage,
                duration: Duration(milliseconds: 350),
                curve: Curves.easeIn,
              );
              print("should stop");
            }
          });
        }
        if (refresh) {
          await sProfileCouponList(context);
        }

        LoadingOverlay.of(context).hide();
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

  void onSeasonalSelected(index) {
    isSeasonalProductAdded[index] = true;
    notifyListeners();
  }

  /////
  void onRecommandedlSelected(index) {
    isRecommendedProductAdded[index] = true;
    notifyListeners();
  }

  ///
  void onOfferSelected(index) {
    isOfferProductAdded[index] = true;
    notifyListeners();
  }

  void launchPhone(String mobNumber, context) async {
    var number = Uri.parse("tel:${mobNumber}");
    if (await canLaunchUrl(number)) {
      await launchUrl(number);
    } else {
      Utils.showPrimarySnackbar(context, "Unable to dial at the moment",
          type: SnackType.error);
    }
  }

  //////All Offer Products
  AllProductsReqModel get shopAllProductsReqModel => AllProductsReqModel(
      offset: offset.toString(), limit: "10", shopId: shopId);

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

///////////////////Update List///
  AddFavReqModel get addFavReqModel => AddFavReqModel(
        shopId: shopId.toString(),
      );

  Future<void> updateAllShopFavList(context, id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString("status") == "guestLoggedIn") {
      Utils().showLoginDialog(context, "Please Login to add shop to favourite");
      return;
    }
    shopId = id.toString();
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

  // Future<void> addToCart(pType, pId, sId, context) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   if (pref.getString("status") == "guestLoggedIn") {
  //     Utils().showLoginDialog(context, "Please Login to add product to cart");
  //     return;
  //   }
  //   LoadingOverlay.of(context).show();
  //   addProductToCartRepo
  //       .addProductToCart(
  //           AddProductToCartReqModel(
  //               productType: pType,
  //               productUnitId: pId.toString(),
  //               shopId: sId.toString(),
  //               quantity: "1"),
  //           pref.getString("successToken"))
  //       .then((response) async {
  //     log("response.body${response.body}");
  //     final result =
  //         AddProductToCartResModel.fromJson(jsonDecode(response.body));
  //     if (response.statusCode == 200) {
  //       Utils.showPrimarySnackbar(context, result.message,
  //           type: SnackType.success);
  //       notifyListeners();
  //     } else {
  //       Utils.showPrimarySnackbar(context, result.message,
  //           type: SnackType.error);
  //       LoadingOverlay.of(context).hide();
  //     }
  //   }).onError((error, stackTrace) {
  //     Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
  //     LoadingOverlay.of(context).hide();
  //   }).catchError(
  //     (Object e) {
  //       Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
  //       LoadingOverlay.of(context).hide();
  //     },
  //     test: (Object e) {
  //       Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
  //       LoadingOverlay.of(context).hide();
  //       return false;
  //     },
  //   );
  // }
  Future<void> addToCart(pType,pId,sId,index,context) async {
    LoadingOverlay.of(context).show();
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
        .then((response) async {
      log("response.body${response.body}");
      final result =
          AddProductToCartResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        await getShopDetails(context, sId, false);
        // isSeasonalProductAdded[index] = true;
        // quantitySeasonalList.removeAt(index);
        // quantitySeasonalList.insert(index, 1);
        // cartItemIdList.removeAt(index);
        // cartItemIdList.insert(index, result.cartItemId);
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
        notifyListeners();
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
        LoadingOverlay.of(context).hide();
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
      LoadingOverlay.of(context).hide();
    }).catchError(
      (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        LoadingOverlay.of(context).hide();
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        LoadingOverlay.of(context).hide();
        return false;
      },
    );
  }

  ShopPCouponsReqModel get shopPCouponReqModel => ShopPCouponsReqModel(
        shopId: shopId.toString(),
      );
  Future<void> sProfileCouponList(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    print(pref.getString("pincode"));
    // if(pref.getString("pincode")==null){
    //   pincode="111111";
    // }
    // else{
    //   pincode=pref.getString("pincode").toString();
    // }
    sProfileCouponRepo
        .sProfileCouponRepo(shopPCouponReqModel, pref.getString("successToken"))
        .then((response) {
      print("Shop List");
      log("Shop_list${response.body}");
      final result = ShopPCouponsResModel.fromJson(jsonDecode(response.body));
      log(response.body);
      if (response.statusCode == 200) {
        sprofilecoupondata = result.sprofilecoupondata;
        shopCouponsList = sprofilecoupondata?.shopCouponsList;
        showLoader(false);
        notifyListeners();
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
        showLoader(false);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
      showLoader(false);
    }).catchError(
      (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        showLoader(false);
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        showLoader(false);
        return false;
      },
    );
  }
  ////////////////////////////////////////////////

  // RemoveItemFromCartReq get remveCouponFromListReq => RemoveItemFromCartReq(
  //       productType: productType,
  //       productUnitId: productUnitId,
  //       quantity: quantity,
  //       shopId: shopId.toString(),
  //     );

  // Future<void> removeFromCart(pType, puId, sId, context) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   LoadingOverlay.of(context).show();
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
  //       await getShopDetails(context, sId, false);
  //       Utils.showPrimarySnackbar(context, result.message,
  //           type: SnackType.success);
  //       notifyListeners();
  //     } else {
  //       Utils.showPrimarySnackbar(context, result.message,
  //           type: SnackType.error);
  //       LoadingOverlay.of(context).hide();
  //     }
  //   }).onError((error, stackTrace) {
  //     Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
  //     LoadingOverlay.of(context).hide();
  //   }).catchError(
  //     (Object e) {
  //       Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
  //       LoadingOverlay.of(context).hide();
  //     },
  //     test: (Object e) {
  //       Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
  //       LoadingOverlay.of(context).hide();
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
        await getShopDetails(context, sId, false);
        // isSeasonalProductAdded[index] = false;
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

///////////////////////////////////////////////////////////////////////////////////

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
      context, CIId, index, pType, pUnitId,type) async {
    LoadingOverlay.of(context).show();
    quantityBtnPressed(true);
    print("*********");
    print(quantitySeasonalList);
    print(quantitySeasonalList[index]);
    print("*********");
    quantityAction = "subtract";
    productType = pType;
    print(cartItemIdSeasonalList);
    if (type == "offer") {
      cartItemId = cartItemIdOfferlList[index].toString();
    } else if (type == "seasonal") {
      cartItemId = cartItemIdSeasonalList[index].toString();
    } else {
      cartItemId = cartItemIdRecommandedList[index].toString();
    }
    // cartItemId = cartItemIdSeasonalList[index].toString();
    print(cartItemId);
    SharedPreferences pref = await SharedPreferences.getInstance();
    cartItemQuantityRepo
        .cartItemQuantity(
            cartItemQuantityRequestModel, pref.getString("successToken"))
        .then((response) async {
      log("response.body${response.body}");
      final result = CartItemQuantityResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if (result.status == 200) {

          if (type == "offer") {
            if(quantityOfferList[index]==0){
              removeFromCart(pType, pUnitId, shopId, index, context);
            }
          } else if (type == "seasonal") {
            if (quantitySeasonalList[index] == 0) {
              removeFromCart(pType, pUnitId, shopId, index, context);
            }
          } else {
            if(quantityRecommandedList[index]==0){
              removeFromCart(pType, pUnitId, shopId, index, context);
            }
          }
          // quantitySeasonalList.removeAt(index);
          // print("${value}valueeeeeeeee");
          // quantitySeasonalList.insert(index, value - 1);
          // int value = quantitySeasonalList[index];


          quantityBtnPressed(false);
          await getShopDetails(context, shopId, false);
          // LoadingOverlay.of(context).hide();
          notifyListeners();
        } else {
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);

          quantityBtnPressed(false);
          LoadingOverlay.of(context).hide();
        }
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
        quantityBtnPressed(false);
        LoadingOverlay.of(context).hide();
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
      quantityBtnPressed(false);
      LoadingOverlay.of(context).hide();
    }).catchError(
      (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        quantityBtnPressed(false);
        LoadingOverlay.of(context).hide();
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        LoadingOverlay.of(context).hide();
        return false;
      },
    );
  }

  Future<void> addItemQuantity(context, CIId, pType, index, type) async {
    LoadingOverlay.of(context).show();
    quantityBtnPressed(true);
    quantityAction = "add";
    if (type == "offer") {
      cartItemId = cartItemIdOfferlList[index].toString();
    } else if (type == "seasonal") {
      cartItemId = cartItemIdSeasonalList[index].toString();
    } else {
      cartItemId = cartItemIdRecommandedList[index].toString();
    }

    productType = pType;
    SharedPreferences pref = await SharedPreferences.getInstance();
    cartItemQuantityRepo
        .cartItemQuantity(
            cartItemQuantityRequestModel, pref.getString("successToken"))
        .then((response) async {
      print("hello");
      log("response.body${response.body}");
      final result =
          CartItemQuantityResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if (result.status == 200) {
          quantityBtnPressed(false);
          await getShopDetails(context, shopId, false);
          // int value = quantitySeasonalList[index];
          // quantitySeasonalList.removeAt(index);
          // quantitySeasonalList.insert(index, value + 1);
          notifyListeners();
        } else {
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
          quantityBtnPressed(false);
          LoadingOverlay.of(context).hide();
        }
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
        quantityBtnPressed(false);
        LoadingOverlay.of(context).hide();
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
      quantityBtnPressed(false);
      LoadingOverlay.of(context).hide();
    }).catchError(
      (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        quantityBtnPressed(false);
        LoadingOverlay.of(context).hide();
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        LoadingOverlay.of(context).hide();
        return false;
      },
    );
  }
}


///////////////////////////////////////
// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:local_supper_market/screen/customer/cart/model/add_product_to_cart_model.dart';
// import 'package:local_supper_market/screen/customer/cart/model/cart_item_quantity_model.dart';
// import 'package:local_supper_market/screen/customer/cart/repository/add_product_to_cart_repo.dart';
// import 'package:local_supper_market/screen/customer/cart/repository/cart_item_quantity_repo.dart';
// import 'package:local_supper_market/screen/customer/home/view/home_screen_view.dart';
// import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
// import 'package:local_supper_market/screen/customer/near_shops/model/add_fav_model.dart';
// import 'package:local_supper_market/screen/customer/near_shops/model/remove_fav_shop_model.dart';
// import 'package:local_supper_market/screen/customer/near_shops/repository/add_fav_shop_repo.dart';
// import 'package:local_supper_market/screen/customer/near_shops/repository/remove_fav_shop_repo.dart';
// import 'package:local_supper_market/screen/customer/near_shops/view/all_near_shops_category_view.dart';
// import 'package:local_supper_market/screen/customer/near_shops/view/all_near_shops_view.dart';
// import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
// import 'package:local_supper_market/screen/customer/shop_profile/model/remove_item_cart_model.dart';
// import 'package:local_supper_market/screen/customer/shop_profile/model/shop_coupons_model.dart';
// import 'package:local_supper_market/screen/customer/shop_profile/model/view_all_offer_products_model.dart';

// import 'package:local_supper_market/screen/customer/shop_profile/repository/all_products_repo.dart';
// import 'package:local_supper_market/screen/customer/shop_profile/repository/customer_view_shop_repo.dart';
// import 'package:local_supper_market/screen/customer/shop_profile/repository/remove_item_from_cart_repo.dart';
// import 'package:local_supper_market/screen/customer/shop_profile/repository/shop_profile_coupons_repo.dart';
// import 'package:local_supper_market/screen/shop_owner/s_dashboard/model/dash_board_model.dart';
// import 'package:local_supper_market/utils/utils.dart';
// import 'package:local_supper_market/widget/loaderoverlay.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ShopProfileViewController extends ChangeNotifier {
//   String shopId = "";
//   String productType = "";
//   String productUnitId = "";
//   String quantity = "";
//   int offset = 0;
//   bool isLoading = true;
//   PageController pageController = PageController();
//   // Data? allproducts;
//   CustomerViewShopRepo customerViewShopRepo = CustomerViewShopRepo();
//   AllOfferProductsRepo allOfferProductsRepo = AllOfferProductsRepo();
//   ShopViewData? shopData;
//   ShopDetails? shopDetails;
//   List<ShopCategory>? shopCategory;
//   List<CustomerProductData>? offerProduct;
//   List<CustomerProductData>? allOfferProducts;
//   List<CustomerProductData>? seasonalProduct;
//   List<CustomerProductData>? recommandedProduct;
//   List<BannerImageData>? bannerImageData;
//   List<ShopCouponsList>? shopCouponsList;
//   SProfileCouponData? sprofilecoupondata;
//   int _currentPage = 0;
//   bool? deliveryAddressStatus;
//   List<bool> isSeasonalProductAdded = [];
//   List<bool> isRecommendedProductAdded = [];
//   List<bool> isOfferProductAdded = [];
//   CartItemQuantityRepo cartItemQuantityRepo = CartItemQuantityRepo();
//   AddProductToCartRepo addProductToCartRepo = AddProductToCartRepo();
//   RemoveCartItemRepo removeCartItemRepo = RemoveCartItemRepo();
//   ShopProfileCouponRepo sProfileCouponRepo = ShopProfileCouponRepo();
//   bool favAllShop = true; /////shop add fvrt
//   AddFavShopRepo addFavShopRepo = AddFavShopRepo();
//   bool isPageRefresh = false;
//   List<bool> isProductAdded = [];

//   Future<void> initState(context, id, refresh) async {
//     if (refresh) {
//       showLoader(true);
//       print("kkkkkkkk");
//       await getShopDetails(context, id, refresh);
//     } else {
//       showLoader(false);
//     }
//   }

//   void showLoader(value) {
//     isLoading = value;
//     notifyListeners();
//   }

//   CustomerViewShopReqModel get customerViewShopReqModel =>
//       CustomerViewShopReqModel(
//         shopId: shopId,
//       );

//   void onBackPressed(screenName, context, cId) {
//     print(screenName);
//   }

//   Future<void> getShopDetails(context, id, refresh) async {
//     print("id$id");
//     shopId = id;
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     print(pref.getString("successToken"));
//     customerViewShopRepo
//         .getShopDetails(
//             customerViewShopReqModel, pref.getString("successToken"))
//         .then((response) async {
//       log("response.body${response.body}");
//       final result =
//           CustomerViewShopResModel.fromJson(jsonDecode(response.body));
//       if (response.statusCode == 200) {
//         deliveryAddressStatus = result.deliveryAddressStatus;
//         shopData = result.data;
//         shopDetails = shopData?.shopDetails;
//         shopCategory = shopData?.shopCategories;
//         offerProduct = shopData?.offerProduct;
//         //for seasonal
//         seasonalProduct = shopData?.seasonalProduct;
//         int seasonProductLength = seasonalProduct?.length ?? 0;
//         isSeasonalProductAdded =
//             List<bool>.filled(seasonProductLength, false, growable: true);
//         for (int i = 0; i < seasonProductLength; i++) {
//           if (seasonalProduct?[i].addToCartCheck == "yes") {
//             isSeasonalProductAdded.insert(i, true);
//           } else {
//             isSeasonalProductAdded.insert(i, false);
//           }
//         }
//         //for recommended
//         recommandedProduct = shopData?.recommandedProduct;
//         int recommandedProductLength = recommandedProduct?.length ?? 0;
//         isRecommendedProductAdded =
//             List<bool>.filled(recommandedProductLength, false, growable: true);
//         for (int i = 0; i < recommandedProductLength; i++) {
//           if (recommandedProduct?[i].addToCartCheck == "yes") {
//             isRecommendedProductAdded.insert(i, true);
//           } else {
//             isRecommendedProductAdded.insert(i, false);
//           }
//         }
//         ////////////////////Offer///////////
//         offerProduct = shopData?.offerProduct;
//         int offerProductLength = offerProduct?.length ?? 0;
//         isOfferProductAdded =
//             List<bool>.filled(offerProductLength, false, growable: true);
//         for (int i = 0; i < offerProductLength; i++) {
//           if (offerProduct?[i].addToCartCheck == "yes") {
//             isOfferProductAdded.insert(i, true);
//           } else {
//             isOfferProductAdded.insert(i, false);
//           }
//         }
//         bannerImageData = shopData?.bannerImages;

//         favAllShop = shopDetails?.shopFavourite == "yes" ? true : false;
//         print("bye");
//         print(favAllShop);
//         print("uivynuibnywetinyiqwn8wq7eyvnb8q8ew");

//         int imageLength = bannerImageData?.length ?? 0;
//         if (bannerImageData!.isNotEmpty) {
//           Timer.periodic(Duration(seconds: 5), (Timer timer) {
//             print(_currentPage);
//             if (_currentPage < imageLength - 1) {
//               _currentPage++;
//               pageController.nextPage(
//                 // _currentPage,
//                 duration: Duration(milliseconds: 350),
//                 curve: Curves.easeIn,
//               );
//               print("still going");
//             } else {
//               _currentPage = 0;
//               pageController.animateToPage(
//                 // _currentPage,
//                 _currentPage,
//                 duration: Duration(milliseconds: 350),
//                 curve: Curves.easeIn,
//               );
//               print("should stop");
//             }
//           });
//         }
//         if (refresh) {
//           await sProfileCouponList(context);
//         }

//         LoadingOverlay.of(context).hide();
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

//   void onSeasonalSelected(index) {
//     isSeasonalProductAdded[index] = true;
//     notifyListeners();
//   }

//   /////
//   void onRecommandedlSelected(index) {
//     isRecommendedProductAdded[index] = true;
//     notifyListeners();
//   }

//   ///
//   void onOfferSelected(index) {
//     isOfferProductAdded[index] = true;
//     notifyListeners();
//   }

//   void launchPhone(String mobNumber, context) async {
//     var number = Uri.parse("tel:${mobNumber}");
//     if (await canLaunchUrl(number)) {
//       await launchUrl(number);
//     } else {
//       Utils.showPrimarySnackbar(context, "Unable to dial at the moment",
//           type: SnackType.error);
//     }
//   }

//   //////All Offer Products
//   AllProductsReqModel get shopAllProductsReqModel => AllProductsReqModel(
//       offset: offset.toString(), limit: "10", shopId: shopId);

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

// ///////////////////Update List///
//   AddFavReqModel get addFavReqModel => AddFavReqModel(
//         shopId: shopId.toString(),
//       );

//   Future<void> updateAllShopFavList(context, id) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     if (pref.getString("status") == "guestLoggedIn") {
//       Utils().showLoginDialog(context, "Please Login to add shop to favourite");
//       return;
//     }
//     shopId = id.toString();
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

//   Future<void> addToCart(pType, pId, sId, context, index) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     if (pref.getString("status") == "guestLoggedIn") {
//       Utils().showLoginDialog(context, "Please Login to add product to cart");
//       return;
//     }
//     LoadingOverlay.of(context).show();
//     addProductToCartRepo
//         .addProductToCart(
//             AddProductToCartReqModel(
//                 productType: pType,
//                 productUnitId: pId.toString(),
//                 shopId: sId.toString(),
//                 quantity: "1"),
//             pref.getString("successToken"))
//         .then((response) async {
//       log("response.body${response.body}");
//       final result =
//           AddProductToCartResModel.fromJson(jsonDecode(response.body));
//       if (response.statusCode == 200) {
//         await getShopDetails(context, sId, false);
//         isProductAdded[index] = true;
//         quantityList.removeAt(index);
//         quantityList.insert(index, 1);
//         cartItemIdList.removeAt(index);
//         cartItemIdList.insert(index, result.cartItemId);
//         Utils.showPrimarySnackbar(context, result.message,
//             type: SnackType.success);
//         notifyListeners();
//       } else {
//         Utils.showPrimarySnackbar(context, result.message,
//             type: SnackType.error);
//         LoadingOverlay.of(context).hide();
//       }
//     }).onError((error, stackTrace) {
//       Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
//       LoadingOverlay.of(context).hide();
//     }).catchError(
//       (Object e) {
//         Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
//         LoadingOverlay.of(context).hide();
//       },
//       test: (Object e) {
//         Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
//         LoadingOverlay.of(context).hide();
//         return false;
//       },
//     );
//   }

//   ShopPCouponsReqModel get shopPCouponReqModel => ShopPCouponsReqModel(
//         shopId: shopId.toString(),
//       );
//   Future<void> sProfileCouponList(context) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     print(pref.getString("successToken"));
//     print(pref.getString("pincode"));
//     // if(pref.getString("pincode")==null){
//     //   pincode="111111";
//     // }
//     // else{
//     //   pincode=pref.getString("pincode").toString();
//     // }
//     sProfileCouponRepo
//         .sProfileCouponRepo(shopPCouponReqModel, pref.getString("successToken"))
//         .then((response) {
//       print("Shop List");
//       log("Shop_list${response.body}");
//       final result = ShopPCouponsResModel.fromJson(jsonDecode(response.body));
//       log(response.body);
//       if (response.statusCode == 200) {
//         sprofilecoupondata = result.sprofilecoupondata;
//         shopCouponsList = sprofilecoupondata?.shopCouponsList;
//         showLoader(false);
//         notifyListeners();
//       } else {
//         Utils.showPrimarySnackbar(context, result.message,
//             type: SnackType.error);
//         showLoader(false);
//       }
//     }).onError((error, stackTrace) {
//       Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
//       showLoader(false);
//     }).catchError(
//       (Object e) {
//         Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
//         showLoader(false);
//       },
//       test: (Object e) {
//         Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
//         showLoader(false);
//         return false;
//       },
//     );
//   }
//   ////////////////////////////////////////////////

//   // RemoveItemFromCartReq get remveCouponFromListReq => RemoveItemFromCartReq(
//   //       productType: productType,
//   //       productUnitId: productUnitId,
//   //       quantity: quantity,
//   //       shopId: shopId.toString(),
//   //     );

//   Future<void> removeFromCart(pType, puId, sId, index, context) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     LoadingOverlay.of(context).show();
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
//         await getShopDetails(context, sId, false);
//         Utils.showPrimarySnackbar(context, result.message,
//             type: SnackType.success);
//         notifyListeners();
//       } else {
//         Utils.showPrimarySnackbar(context, result.message,
//             type: SnackType.error);
//         LoadingOverlay.of(context).hide();
//       }
//     }).onError((error, stackTrace) {
//       Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
//       LoadingOverlay.of(context).hide();
//     }).catchError(
//       (Object e) {
//         Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
//         LoadingOverlay.of(context).hide();
//       },
//       test: (Object e) {
//         Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
//         LoadingOverlay.of(context).hide();
//         return false;
//       },
//     );
//   }

// ////////////////////////////////////////////////////////////////
//   bool isQuanityBtnPressed = false;
//   String cartItemId = "";
//   String quantityAction = "";
//   List cartItemIdList = [];
//   List quantityList = [];

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
