import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_supper_market/screen/customer/my_vouchers/model/my_voucher_model.dart';
import 'package:local_supper_market/screen/customer/my_vouchers/repository/my_voucher_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyVocherScreenController extends ChangeNotifier {
  MyVoucherRepo myVoucherRepo = MyVoucherRepo();
  bool isLoading = true;
  VoucherDetails? voucherDetails;
  List<MyVoucherList>? myvoucherListData;
  Future<void> initState(context) async {
    CustomerVoucherList(context);
    notifyListeners();
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  //////////////////////////////////////
  Future<void> CustomerVoucherList(context) async {
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("bnvuuiwveuciiutwmibijmiuey");
    print(pref.getString("successToken"));
    myVoucherRepo.voucherList(pref.getString("successToken")).then((response) {
      print(response.statusCode);
      log("ytr${response.body}");
      final result = MyVoucher.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        voucherDetails = result.voucherDetails;
        myvoucherListData = voucherDetails?.myvoucherListData;
        // print(myvoucherListData?[0]);
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

  // bool isOfferCopied = false;
  copyCode(context, offer) {
    // isOfferCopied = true;
    notifyListeners();
    Clipboard.setData(ClipboardData(text: offer)).then((_) {
      Utils.showPrimarySnackbar(context, "Coupon Code Copied",
          type: SnackType.success);
    });
  }
}
