import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/favourites/model/all_fvrt_shops.dart';
import 'package:local_supper_market/screen/customer/favourites/repository/all_shop_fvrt_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritesController extends ChangeNotifier{
  AllFvrtShopsRepo allFvrtShopsRepo=AllFvrtShopsRepo();
  bool isFavShopPressed=true;
  List<FavouriteData> ? favShopList;
  bool isLoading=true;

  Future<void> initState(context) async {
    await getAllFavouriteShop(context);
  }

  onFavouriteShopTapped(){
    isFavShopPressed=true;
    notifyListeners();
  }
  onFavouriteProductTapped(){
    isFavShopPressed=false;
    notifyListeners();
  }

  Future<void> getAllFavouriteShop(context) async {
    isLoading=true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    allFvrtShopsRepo.allfvrtShops(pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result =
      GetAllFavShopsResModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        favShopList=result.data;
        isLoading=false;
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