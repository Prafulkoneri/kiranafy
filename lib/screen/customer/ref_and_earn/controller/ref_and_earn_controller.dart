import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/account/model/faq_model.dart';

import 'package:local_supper_market/screen/customer/account/model/profile_detail_cmodel.dart';
import 'package:local_supper_market/screen/customer/account/repository/c_profile_repo.dart';
import 'package:local_supper_market/screen/customer/account/repository/faq_repository_repo.dart';
import 'package:local_supper_market/screen/customer/account/repository/sign_out_repo.dart';

import 'package:local_supper_market/screen/customer/favourites/view/favourites_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/my_order/view/my_order_view.dart';
import 'package:local_supper_market/screen/customer/notifications/view/notification_view.dart';
import 'package:local_supper_market/screen/customer/ref_and_earn/model/ref_and_earn_model.dart';
import 'package:local_supper_market/screen/customer/ref_and_earn/repository/ref_and_earn_repo.dart';
import 'package:local_supper_market/screen/customer/ref_and_earn/view/ref_and_earn_view.dart';
import 'package:local_supper_market/screen/customer/update_profile/view/update_profile_view.dart';
import 'package:local_supper_market/screen/on_boarding/view/on_boarding_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/model/sign_out_model.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:provider/provider.dart';
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
    print("hello printitng");
    showLoader(true);
    showLoader(false);
  }


  // Future<void> getReferAndEarnDetails(context) async {
  //   showLoader(true);
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   refAndEarnRepo
  //       .getRefAndEarnData(pref.getString("successToken"))
  //       .then((response) {
  //     print("successToken");
  //     final result =
  //     ReferAndEarnResModel.fromJson(jsonDecode(response.body));
  //     print(response.statusCode);
  //     log(response.body);
  //     if (response.statusCode == 200) {
  //       referAndEarnCouponDetails=result.couponDetails;
  //       showLoader(false);
  //       notifyListeners();
  //
  //     }
  //     else {
  //       Utils.showPrimarySnackbar(context, result.message,
  //           type: SnackType.error);
  //     }
  //   }).onError((error, stackTrace) {
  //     Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
  //   }).catchError(
  //         (Object e) {
  //       Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
  //     },
  //     test: (Object e) {
  //       Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
  //       return false;
  //     },
  //   );
  // }

}
