import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_supper_market/screen/customer/coupons/model/coupon_all_model.dart';
import 'package:local_supper_market/screen/customer/coupons/model/coupon_filtter_model.dart';
import 'package:local_supper_market/screen/customer/coupons/repository/coupon_all_repo.dart';
import 'package:local_supper_market/screen/customer/coupons/repository/coupon_filtter_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CAllCouponController extends ChangeNotifier {
  CAllCouponList allCouponListRepo = CAllCouponList();
  CouponFiltterRepo couponFiltterRepo = CouponFiltterRepo();
  List<CategoryList>? categoryList;
  List<ShopOwnerList>? shopOwnerList;
  int selectedIndex = 0;
  bool isLoading = true;
  bool isOfferCopied = false;
  List<ShopEnquiriesDetail>? shopEnquiriesDetails;
  List<FilterCouponList>? filterCouponList;
  AllCouponListData? allCouponlistdata;
  String categoryId = "";
  String shopId = "";
  String? uptoValue = "";
  Future<void> initState(context, upValue, sId, cId) async {
    await getAllCouponList(context, upValue, sId, cId, 0);
    await couponFiltterList(
      context,
    );
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

//  CustomerCouponListRequestModel get productAsPerCategoryReqModel =>
//       CustomerCouponListRequestModel(
//         categoryId: categoryId,
//         shopId: shopId,
//       );
  Future<void> getAllCouponList(context, upValue, sId, cId, index) async {
    selectedIndex = index;
    uptoValue = upValue;
    categoryId = cId;
    shopId = sId;

    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    allCouponListRepo
        .couponList(
      pref.getString("successToken"),
      uptoValue.toString(),
      categoryId.toString(),
      shopId.toString(),
    )
        .then((response) {
      print(response.body);
      final result =
          CustomerCouponListResponseModel.fromJson(jsonDecode(response.body));
      log(response.body);
      if (response.statusCode == 200) {
        allCouponlistdata = result.allCouponlistdata;
        if (filterCouponList == null) {
          filterCouponList = result.filterCouponList;
        }

        shopEnquiriesDetails = allCouponlistdata?.shopEnquiriesDetails;
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

  void onDismiss() {
    isOfferCopied = false;
    notifyListeners();
  }

  copyCode(context, offer) {
    isOfferCopied = true;
    notifyListeners();
    Clipboard.setData(ClipboardData(text: offer)).then((_) {
      // Utils.showPrimarySnackbar(context, "coupon code copid",
      //     type: SnackType.success);
    });
    Timer(Duration(seconds: 3), () async {
      isOfferCopied = false;
      notifyListeners();
    });
  }

  copyCodeForCoupanList(context, offerMsg) {
    Clipboard.setData(ClipboardData(text: offerMsg)).then((_) {
      Utils.showPrimarySnackbar(context, "Coupon Code Copied",
          type: SnackType.success);
    });
  }

  ////////////////////////////////////////////////////////
  Future<void> couponFiltterList(context) async {
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    couponFiltterRepo
        .couponFiltter(pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result =
          CustomerCouponFilttermodel.fromJson(jsonDecode(response.body));
      log(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        categoryList = result.categoryList;
        shopOwnerList = result.shopOwnerList;
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

  void onShopSelected(value) {
    shopId = value;
    notifyListeners();
  }

  void onCategorySelected(value) {
    categoryId = value;
    notifyListeners();
  }

  //////////////
  void onClearFunction(context) {
    shopId = "";
    categoryId = "";
    getAllCouponList(context, "", "", "", 0);
    // Navigator.pop(context);
    notifyListeners();
  }
}
