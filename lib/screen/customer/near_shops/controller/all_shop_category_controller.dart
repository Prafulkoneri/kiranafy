import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/add_fav_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/customer_view_all_category_shop_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/customer_view_all_shop_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/remove_fav_shop_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/search_shop_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/shop_area_list.model.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/add_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/customer_view_all_category_repo.dart';

import 'package:local_supper_market/screen/customer/near_shops/repository/remove_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/search_shop_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/shop_area_list_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/area_model.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllCategoryShopController extends ChangeNotifier {
  CustomerViewAllCategoryShopRepo customerViewAllCategoryShopRepo =
      CustomerViewAllCategoryShopRepo();
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
  String categoryId = "";
  TextEditingController searchController = TextEditingController();
  SearchShopRepo searchShopRepo = SearchShopRepo();
  SearchShopData? searchshopData;
  ShopAreaListRepo shopAreaListRepo = ShopAreaListRepo();
  String areaId = "";
  String rating = "";
  List<AreaData>? areaList;
  CustomerViewAllCategoryShopReqModel get customerViewAllCategoryShopReqModel =>
      CustomerViewAllCategoryShopReqModel(
          offset: offset.toString(),
          limit: "10",
          categoryId: categoryId,
          rating: rating,
          areaId: areaId);

  Future<void> initState(context, id, refresh) async {
    searchController.clear();
    if (refresh) {
      areaId = "";
      rating = "";
      isLoading = true;
      print(id);
      allShops.clear();
      offset = 0;
      getAllShops(context, id);
    } else {
      isLoading = false;
    }
    getAreaList(context);
    notifyListeners();
  }

  Future<void> getAllShops(context, id) async {
    if (offset == 0) {
      isLoading = true;
    }
    categoryId = id;
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("kkkkkkkkkk");
    // if (pref.getString("pincode") == null) {
    //   pincode = "111111";
    // } else {
    //   pincode = pref.getString("pincode").toString();
    // }
    customerViewAllCategoryShopRepo
        .getAllCategoryShopList(
            customerViewAllCategoryShopReqModel, pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result = CustomerViewAllCategoryShopResModel.fromJson(
          jsonDecode(response.body));
      if (response.statusCode == 200) {
        print("111111123e24errfsdfs");
        allShops.clear();
        data = result.data;
        nearByShop = data?.nearByShops;
        allShops.addAll(result.data?.allShops ?? []);
        favNearByShop =
            List<bool>.filled(nearByShop?.length ?? 0, false, growable: true);
        favAllShop =
            List<bool>.filled(allShops.length ?? 0, false, growable: true);
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

///////Favrt
  AddFavReqModel get addFavReqModel => AddFavReqModel(
        shopId: shopId.toString(),
      );

  Future<void> updateNearByFavList(context, id, index) async {
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
        favAllShop[index] = false;
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

  Future<void> removeAllShopFavList(context, id, index) async {
    shopId = id.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    removeFavShopRepo
        .updateRemoveFavShop(removeFavReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = RemoveFavResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        favAllShop[index] = true;
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
    showPaginationLoader = true;
    print("hello");
    offset = offset + 1;
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("kkkkkkkkkk");
    customerViewAllCategoryShopRepo
        .getAllCategoryShopList(
            customerViewAllCategoryShopReqModel, pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result = CustomerViewAllCategoryShopResModel.fromJson(
          jsonDecode(response.body));
      if (response.statusCode == 200) {
        print("111111123e24errfsdfs");
        // allShops.clear();
        data = result.data;
        nearByShop = data?.nearByShops;
        allShops.addAll(result.data?.allShops ?? []);
        favNearByShop =
            List<bool>.filled(nearByShop?.length ?? 0, false, growable: true);
        favAllShop =
            List<bool>.filled(allShops.length ?? 0, false, growable: true);
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
    // await getAllShops(context, categoryId);
    isLoading = false;

    notifyListeners();
  }

  SearchShopRequestModel get searchShopReqModel => SearchShopRequestModel(
        shopName: searchController.text,
      );

  Future<void> shopSearchList(context) async {
    print(searchController);
    if (searchController.text.isNotEmpty) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      print(pref.getString("successToken"));
      searchShopRepo
          .searchShop(searchShopReqModel, pref.getString("successToken"))
          .then((response) {
        print("isSearching");
        log("response.body${response.body}");
        final result =
            SearchShopResponseModel.fromJson(jsonDecode(response.body));
        if (response.statusCode == 200) {
          searchshopData = result.searchshopData;
          nearByShop = searchshopData?.nearByShops;
          allShops = searchshopData?.allShops ?? [];
          // if (productList!.isEmpty) {
          //   Utils.showPrimarySnackbar(context, "no product found",
          //       type: SnackType.error);
          // }
          // showLoader(false);
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
      await getAllShops(context, categoryId);
    }
  }

  ////////////////////////////////////////////////////////////////

  ///////////////////////////////////
  Future<void> onAreaSelected(value) async {
    areaId = int.parse(value.toString()).toString();
    notifyListeners();
  }

  Future<void> onRatingSelected(value) async {
    rating = int.parse(value.toString()).toString();
    notifyListeners();
  }
////////////////////////////////////////////

  Future<void> clearFilter(context) async {
    areaId = "";
    rating = "";
    LoadingOverlay.of(context).show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    shopAreaListRepo
        .getShopAreaList(pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = ShopAreaListResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        // areaList = result.areaList;
        // rating;
        // showLoader(false);
        Navigator.pop(context);
        areaId = "";
        rating = "";
        LoadingOverlay.of(context).hide();
        getAllShops(context, categoryId);
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

//////////////////////////////////////////////////////////////////
  Future<void> getAreaList(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    shopAreaListRepo
        .getShopAreaList(pref.getString("successToken"))
        .then((response) {
      final result = ShopAreaListResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        log(response.body);
        areaList = result.areaList;
        // if (result.areaData!.isEmpty) {
        //   Utils.showPrimarySnackbar(context, "No Area Found",
        //       type: SnackType.error);
        // }
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
  //////////////////////////////////////

  Future<void> applyFilter(context) async {
    LoadingOverlay.of(context).show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    shopAreaListRepo
        .getShopAreaList(pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = ShopAreaListResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        // areaList = result.areaList;
        // showLoader(false);
        LoadingOverlay.of(context).hide();
        Navigator.pop(context);
        getAllShops(context, categoryId);
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
