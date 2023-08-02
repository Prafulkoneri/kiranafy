import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_supper_market/screen/customer/coupons/model/coupon_all_model.dart';
import 'package:local_supper_market/screen/customer/coupons/repository/coupon_all_repo.dart';
import 'package:local_supper_market/screen/customer/my_order/repository/my_order_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CAllCouponController extends ChangeNotifier {
  CAllCouponList allCouponListRepo = CAllCouponList();
  bool  isLoading=true;
  bool isOfferCopied = false;
  AllCouponListData? allCouponlistdata;
  List<ShopEnquiriesDetail>? shopEnquiriesDetails;

  Future<void> initState(
      context,
      ) async {
    await getAllCouponList(
      context,
    );
  }

  showLoader(value){
    isLoading=value;
    notifyListeners();
  }
  Future<void> getAllCouponList(context) async {
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    allCouponListRepo.couponList(pref.getString("successToken")).then((response) {
      print(response.body);
      final result = CustomerCouponListModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        allCouponlistdata = result.allCouponlistdata;
        shopEnquiriesDetails=allCouponlistdata?.shopEnquiriesDetails;
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
}
