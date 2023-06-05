import 'dart:convert';
import 'dart:developer';


import 'package:flutter/cupertino.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/add_fav_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/customer_view_all_shop_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/remove_fav_shop_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/add_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/customer_view_all_shop_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/remove_fav_shop_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllShopController extends ChangeNotifier {
  CustomerViewAllShopRepo customerViewAllShopRepo = CustomerViewAllShopRepo();
  String pincode = "111111";
  List<NearByShops>? nearByShop;
  Data? data;
  String? shopId = "";
   List<AllShops> allShops = [];
  AddFavShopRepo addFavShopRepo = AddFavShopRepo();
  RemoveFavShopRepo removeFavShopRepo = RemoveFavShopRepo();
  List<bool> favNearByShop = [];
  List<bool> favAllShop = [];
  bool isLoading = true;
  ScrollController scrollController = ScrollController();
  int offset = 0;

  bool showPaginationLoader = false;


  CustomerViewAllShopReqModel get customerViewAllShopReqModel =>
      CustomerViewAllShopReqModel(
          pincode: pincode, offset: offset.toString(), limit: "5");


  Future<void> initState(context,refresh)async{
    if(refresh) {
      isLoading = true;
      allShops.clear();
      offset = 0;
      getAllShops(context);
    }
    else{
      isLoading = false;
    }
    notifyListeners();
    }

  Future<void> getAllShops(context) async {
    if(offset==0){
      isLoading = true;
    }
    showPaginationLoader = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("kkkkkkkkkk");
    if (pref.getString("pincode") == null) {
      pincode = "111111";
    } else {
      pincode = pref.getString("pincode").toString();
    }
    customerViewAllShopRepo
        .getAllShopList(
            customerViewAllShopReqModel, pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result =
          CustomerViewAllShopResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        data = result.data;
        nearByShop = data?.nearByShops;

        allShops.addAll(result.data?.allShops ?? []);
        favNearByShop = List<bool>.filled(nearByShop?.length ?? 0, false, growable: true);
        favAllShop = List<bool>.filled(allShops.length ?? 0, false, growable: true);
        int length1 = nearByShop?.length ?? 0;
        int length2 = allShops.length ?? 0;
        for (int i = 0; i < length1; i++) {
          if (nearByShop?[i].isFavourite == "yes") {
            favNearByShop.insert(i, true);
          }
        }
        for (int i = 0; i < length2; i++) {
          if (allShops[i].isFavourite == "yes") {
            favAllShop.insert(i, true);
          }
        }
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

  AddFavReqModel get addFavReqModel => AddFavReqModel(
        shopId: shopId.toString(),
      );

  Future<void> updateNearByFavList(context, id, index) async {
    shopId = id.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    addFavShopRepo
        .updateAddFavShop(addFavReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = AddFavResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        favNearByShop[index] = true;
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

  Future<void> updateAllShopFavList(context, id, index) async {
    shopId = id.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    addFavShopRepo
        .updateAddFavShop(addFavReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = AddFavResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        favAllShop[index] = true;
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

  Future<void> removeNearByFavList(context, id, index) async {
    shopId = id.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    removeFavShopRepo
        .updateRemoveFavShop(removeFavReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = RemoveFavResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        favNearByShop[index] = false;
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

  Future<void> removeAllShopFavList(context, id, index) async {
    shopId = id.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    removeFavShopRepo
        .updateRemoveFavShop(removeFavReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = RemoveFavResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        favAllShop[index] = false;
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

  Future<void> onScrollMaxExtent(context) async {

        print("hello");
        offset = offset + 1;
        await getAllShops(context);
        isLoading = false;

        notifyListeners();
  }
}
