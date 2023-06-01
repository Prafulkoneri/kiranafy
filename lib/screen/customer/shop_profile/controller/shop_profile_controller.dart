import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/add_fav_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/remove_fav_shop_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/add_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/remove_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/view_all_offer_products.dart';

import 'package:local_supper_market/screen/customer/shop_profile/repository/all_products_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/repository/customer_view_shop_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopProfileController extends ChangeNotifier {
  String shopId = "";
  int offset = 0;
  bool? isLoading = true;
  bool? showPaginationLoader = true;
  Data? allproducts;
  CustomerViewShopRepo customerViewShopRepo = CustomerViewShopRepo();
  ShopData? shopData;
  ShopDetails? shopDetails;
  List<ShopCategory>? shopCategory;
  List<OfferProduct>? offerProduct;
  List<AllOfferProducts>? allOfferProducts;
  List<SeasonalProduct>? seasonalProduct;
  List<RecommandedProducts>? recommandedProduct;

  bool favAllShop = true; /////shop add fvrt
  AddFavShopRepo addFavShopRepo = AddFavShopRepo();

  Future<void> initState(context, id) async {
    await getShopDetails(context, id);
    await getAllOfferes(context, id);

    notifyListeners();
  }

  CustomerViewShopReqModel get customerViewShopReqModel =>
      CustomerViewShopReqModel(
        shopId: shopId,
      );

  Future<void> getShopDetails(context, id) async {
    print("id$id");
    shopId = id;
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    customerViewShopRepo
        .getShopDetails(
            customerViewShopReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result =
          CustomerViewShopResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        shopData = result.data;
        shopDetails = shopData?.shopDetails;
        shopCategory = shopData?.shopCategories;
        offerProduct = shopData?.offerProduct;
        seasonalProduct = shopData?.seasonalProduct;
        recommandedProduct = shopData?.recommandedProduct;
        favAllShop = shopDetails?.shopFavourite == "yes" ? true : false;
        print("bye");
        print(favAllShop);
        print("uivynuibnywetinyiqwn8wq7eyvnb8q8ew");
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
  AllOfferProductsRepo allOfferProductsRepo = AllOfferProductsRepo();

  Future<void> getAllOfferes(context, shopId) async {
    isLoading = true;

    SharedPreferences pref = await SharedPreferences.getInstance();
    allOfferProductsRepo
        .getAllOffereProducts(
            shopAllProductsReqModel, pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result = ViewAllOfferProducts.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        allproducts = result.data;
        allOfferProducts = allproducts?.offerProducts;
        isLoading = false;
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

  ///////////////Seasonal Products/////////
  // AllSeasonalProductsReqModel get shopAllSeasonalReqModel =>
  //     AllSeasonalProductsReqModel(
  //         offset: offset.toString(), limit: "10", shopId: shopId);
  // AllOfferProductsRepo allSeasonalProductsRepo = AllOfferProductsRepo();

  // Future<void> getAllSeasonalProducts(context, shopId) async {
  //   isLoading = true;

  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   allOfferProductsRepo
  //       .getAllOffereProducts(
  //           shopAllProductsReqModel, pref.getString("successToken"))
  //       .then((response) {
  //     log(response.body);
  //     final result = ViewAllOfferProducts.fromJson(jsonDecode(response.body));
  //     if (response.statusCode == 200) {
  //       allseasonalproducts = result.
  //       allSeasonalProducts = allseasonalproducts?.seasonalProducts;
  //       isLoading = false;
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
//////Add Shop to fvrt

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
}
