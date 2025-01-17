import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/account/model/faq_model.dart';


import 'package:local_supper_market/screen/customer/ref_and_earn/model/ref_and_earn_model.dart';
import 'package:local_supper_market/screen/customer/ref_and_earn/repository/ref_and_earn_repo.dart';

import 'package:local_supper_market/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReferAndEarnController extends ChangeNotifier {

  RefAndEarnRepo  refAndEarnRepo= RefAndEarnRepo();
  ReferAndEarnCouponDetails ? referAndEarnCouponDetails;

  bool isLoading = true;
  List<CustomerFaqDataList>? customerfaqdataList;
  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }


  Future<void> initState(context) async {
    getReferAndEarnDetails(context);
  }


  Future<void> getReferAndEarnDetails(context) async {
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    refAndEarnRepo
        .getRefAndEarnData(pref.getString("successToken"))
        .then((response) {
      print("successToken");
      final result =
      ReferAndEarnResModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      log(response.body);
      if (response.statusCode == 200) {
        referAndEarnCouponDetails=result.couponDetails;
        showLoader(false);
        notifyListeners();

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

}
