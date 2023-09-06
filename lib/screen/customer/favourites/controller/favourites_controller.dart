import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/favourites/model/all_fav_product_model.dart';
import 'package:local_supper_market/screen/customer/favourites/model/all_fvrt_shops.dart';
import 'package:local_supper_market/screen/customer/favourites/repository/all_product_fav_repo.dart';
import 'package:local_supper_market/screen/customer/favourites/repository/all_shop_fvrt_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/add_fav_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/remove_fav_shop_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/add_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/remove_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/shop_as_per_pincode_all_near_shops.dart';
import 'package:local_supper_market/screen/customer/products/model/remove_admin_product_from_fav_model.dart';
import 'package:local_supper_market/screen/customer/products/model/remove_custom_product_from_fav_model.dart';
import 'package:local_supper_market/screen/customer/products/repository/remove_admin_product_fav_repo.dart';
import 'package:local_supper_market/screen/customer/products/repository/remove_custom_product_fav_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritesController extends ChangeNotifier {
  AllFvrtShopsRepo allFvrtShopsRepo = AllFvrtShopsRepo(); //shop
  AllFvrtProductRepo allfavProductRepo = AllFvrtProductRepo(); //product
  AddFavShopRepo addFavShopRepo = AddFavShopRepo();
  bool isFavShopPressed = true;
  List<FavouriteData>? favShopList;
  FavProductData? favProductData; //product
  List<AdminProduct>? adminProductList; //product
  List<AdminProduct>? customProductList;
  List <AdminProduct> allProduct=[];//product
  bool isLoading = true;
  String shopId = "";
  RemoveFavShopRepo removeFavShopRepo = RemoveFavShopRepo();
  List<bool> fav = [];
  List<bool> favAdminproduct = [];
  List<bool> favAllproduct = [];
  List<bool> favCustomproduct = [];
  String productId = "";
  RemoveAdminFvrtProductRepo removeFavProductRepo =
      RemoveAdminFvrtProductRepo();
  RemoveCustomFvrtProductRepo removeCustomFavProductRepo =
      RemoveCustomFvrtProductRepo();

  Future<void> initState(context) async {
    isFavShopPressed = true;
    favShopList?.clear();
    adminProductList?.clear();
    customProductList?.clear();
    isLoading = true;
    await getAllFavouriteShop(context);
    await getAllFavouriteProduct(context);
  }

  onFavouriteShopTapped() {
    isFavShopPressed = true;
    notifyListeners();
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  onFavouriteProductTapped() {
    isFavShopPressed = false;
    notifyListeners();
  }

  Future<void> getAllFavouriteShop(context) async {
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    allFvrtShopsRepo
        .allfvrtShops(pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result = GetAllFavShopsResModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        favShopList = result.data;
        fav = List<bool>.filled(favShopList?.length ?? 0, true, growable: true);
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

  AddFavReqModel get addFavReqModel => AddFavReqModel(
        shopId: shopId.toString(),
      );

  Future<void> updateFavList(context, id, index) async {
    shopId = id.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    addFavShopRepo
        .updateAddFavShop(addFavReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = AddFavResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        fav[index] = true;
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

  RemoveFavReqModel get removeFavReqModel => RemoveFavReqModel(
        shopId: shopId.toString(),
      );

  Future<void> removeFavList(context, id, index) async {
    shopId = id.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    removeFavShopRepo
        .updateRemoveFavShop(removeFavReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = RemoveFavResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        fav[index] = false;
        favShopList?.removeAt(index);
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

  ///////////// Fav Product List////////////
  Future<void> getAllFavouriteProduct(context) async {
    allProduct.clear();
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    allfavProductRepo
        .allfvrtProductRepo(pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result = FavProductResModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        favProductData = result.data;
        adminProductList = favProductData?.adminProducts;
        customProductList = favProductData?.customProducts;
        allProduct.clear();
        allProduct.addAll(adminProductList??[]);
        allProduct.addAll(customProductList??[]);
        favAllproduct= List<bool>.filled(allProduct.length, true,
                growable: true);
        // favAdminproduct = List<bool>.filled(adminProductList?.length ?? 0, true,
        //     growable: true);
        // favCustomproduct = List<bool>.filled(
        //     customProductList?.length ?? 0, true,
        //     growable: true);
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

  RemoveAdminProductReqModel get removeFavProductReqModel =>
      RemoveAdminProductReqModel(
          shopId: shopId.toString(), productId: productId.toString());

  RemoveCustomProductReqModel get removeCustomeProductReqModel =>
      RemoveCustomProductReqModel(
          shopId: shopId.toString(), productId: productId.toString());

  Future<void> removeAdminFavProduct(context, sID, pID, index) async {
    shopId = sID.toString();
    productId = pID.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    removeFavProductRepo
        .removeAdminProductRepo(
            removeFavProductReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = RemoveFavResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if(result.status==200) {
          favAllproduct[index] = false;
          allProduct.removeAt(index);
          print("hello");
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.success);
          notifyListeners();
        }
        else{
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
        }
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

  Future<void> removeCustomFavProduct(context, sID, pID, index) async {
    productId = pID.toString();
    shopId = sID.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    removeCustomFavProductRepo
        .removeCustomProductRepo(
            removeCustomeProductReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result =
          RemoveCustomProductResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if(result.status==200){
          favAllproduct[index] = false;
          allProduct.removeAt(index);
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.success);
          notifyListeners();
        }
        else{
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
        }

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
