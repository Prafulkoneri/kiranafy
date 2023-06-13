import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/model/coupons_list_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/repository/coupons_list_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SCouponsListController extends ChangeNotifier {
  CouponsListRepo couponsListRepo = CouponsListRepo();
  List<CouponListData>? couponsListData;
  bool isLoading = true;

  Future<void> initState(
    context,
  ) async {
    await getCouponsList(context);
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

  copyCode(context, offer) {
    Clipboard.setData(ClipboardData(text: offer)).then((_) {
      Utils.showPrimarySnackbar(context, "coupon code copid",
          type: SnackType.success);
    });
  }
}
