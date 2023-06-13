import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/model/coupon_view_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/model/coupons_list_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/model/delete_coupons_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/repository/coupon_view_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/repository/coupons_delete_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/repository/coupons_list_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SCouponsListController extends ChangeNotifier {
  CouponsListRepo couponsListRepo = CouponsListRepo();
  List<CouponListData>? couponsListData;
  CouponViewData? couponViewData;
  String shopName = "";
  bool isLoading = true;
  String couponId = "";
  DeleteCouponsRepo deleteCouponsRepo = DeleteCouponsRepo();
  ViewCouponsDetailsRepo viewCouponsDetailsRepo = ViewCouponsDetailsRepo();
  ViewCouponsDetailRequestModel get viewCouponsRequestModel =>
      ViewCouponsDetailRequestModel(couponId: couponId.toString());

  DeleteCouponsReqModel get deleteCouponsReqModel =>
      DeleteCouponsReqModel(couponId: couponId.toString());

  Future<void> initState(
    context,
  ) async {
    await getCouponsList(context);
    await viewCouponsDetail(couponId, context);
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getCouponsList(context) async {
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    couponsListRepo
        .getAllCouponsList(pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result = CouponsListModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        couponsListData = result.data;
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

  ///Copy Coupon Code///
  copyCode(context, offer) {
    Clipboard.setData(ClipboardData(text: offer)).then((_) {
      Utils.showPrimarySnackbar(context, "coupon code copid",
          type: SnackType.success);
    });
  }

  //////////////////////////End//////////////////////////

////////Start Delete Coupons Repo//////////
  Future<void> deleteCoupons(context, index, couponsId) async {
    couponId = couponsId.toString();

    SharedPreferences pref = await SharedPreferences.getInstance();

    deleteCouponsRepo
        .deleteCoupons(deleteCouponsReqModel, pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result = DeleteCouponsResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if (result.status == 200) {
          couponsListData?.removeAt(index);
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.success);
        } else {
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
        }
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

  //////////////Coupons View Detail//////////////
  Future<void> viewCouponsDetail(context, couponsId) async {
    couponId = couponsId.toString();

    SharedPreferences pref = await SharedPreferences.getInstance();

    viewCouponsDetailsRepo
        .viewCouponsDetail(
            viewCouponsRequestModel, pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result =
          ViewCoupnDetailResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if (result.status == 200) {
          couponViewData = result.data;
          shopName = result.shopName ?? "";

          // Utils.showPrimarySnackbar(context, result.message,
          //     type: SnackType.success);
        } else {
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
        }
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
