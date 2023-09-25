import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/Offer_seasonal_recommanded/model/remove_srf_model.dart';
import 'package:local_supper_market/screen/shop_owner/Offer_seasonal_recommanded/model/seasonal_recommanded_fulfil_model.dart';
import 'package:local_supper_market/screen/shop_owner/Offer_seasonal_recommanded/repository/remove_srf_products_repo.dart';
import 'package:local_supper_market/screen/shop_owner/Offer_seasonal_recommanded/repository/seasonal_fulFil_recommanded_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopSeasonalRecommandedOfferProductsController extends ChangeNotifier {
  bool isRecommadedPressed = true;
  bool isSeasonalPressed = false;
  bool isFulFilPressed = false;
  bool isLoading = true;
  AllProductsData? allproducts;
  List<Product>? recommendedProducts;
  List<Product>? seasonalProducts;
  List<Product>? fullfillYourCravingsProducts;
  List<UnitDetail>? unitDetails;
  SRFProductListRepo sRFProductRepo = SRFProductListRepo();
  RemoveSRFProductsRepo removeSRFProductRepo = RemoveSRFProductsRepo();
  String productId = "";
  String productsType = "";
  String removeFrom = "";
  Future<void> initState(context, selectedProduct, refresh) async {
    if (selectedProduct == "recommended") {
      isRecommadedPressed = true;
      isSeasonalPressed = false;
      isFulFilPressed = false;
    }
    if (selectedProduct == "seasonal") {
      isSeasonalPressed = true;
      isRecommadedPressed = false;
      isFulFilPressed = false;
    }
    if (selectedProduct == "fullFill") {
      isSeasonalPressed = false;
      isRecommadedPressed = false;
      isFulFilPressed = true;
    }
    showLoader(false);
    if (refresh) {
      await getAllProductsList(context);
    }
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  onRecommendedTapped() {
    isRecommadedPressed = true;
    isFulFilPressed = false;
    isSeasonalPressed = false;
    notifyListeners();
  }

  onSeasonalProductTapped() {
    isSeasonalPressed = true;
    isRecommadedPressed = false;
    isFulFilPressed = false;
    notifyListeners();
  }

  onFullFilProductTapped() {
    isFulFilPressed = true;
    isSeasonalPressed = false;
    isRecommadedPressed = false;
    notifyListeners();
  }

  Future<void> getAllProductsList(context) async {
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    sRFProductRepo.sRFProducts(pref.getString("successToken")).then((response) {
      print(response.body);
      final result =
          RecommandedSeasonalFulFilModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        allproducts = result.allproducts;
        recommendedProducts = allproducts?.recommendedProducts;
        seasonalProducts = allproducts?.seasonalProducts;
        fullfillYourCravingsProducts =
            allproducts?.fullfillYourCravingsProducts;

        showLoader(false);
        notifyListeners();
      }
      else if(response.statusCode == 401){
        Utils().logoutUser(context);
      }
      else {
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
  RemoveSRFProductsRequestModel get removeSRFProductsRequestModel =>
      RemoveSRFProductsRequestModel(
          productId: productId,
          productsType: productsType,
          removeFrom: removeFrom);

  Future<void> removeSRFProducts(context, index, id, pType, rFrom) async {
    LoadingOverlay.of(context).show();
    productId = id.toString();
    productsType = pType.toString();
    removeFrom = rFrom.toString();
    isLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    removeSRFProductRepo.SrfRemoveProducts(
            removeSRFProductsRequestModel, pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result =
          RemoveSRFProductsResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if (result.status == 200) {
          if (removeFrom == "recommended_product") {
            print("eeeeeeeeeeeeeeeeeeeeeeeeeee");
            recommendedProducts?.removeAt(index);
          }
          if (removeFrom == "seasonal_product") {
            seasonalProducts?.removeAt(index);
          }
          if (removeFrom == "fullfill_your_cravings") {
            fullfillYourCravingsProducts?.removeAt(index);
          }

          LoadingOverlay.of(context).hide();
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.success);
          notifyListeners();
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
}
