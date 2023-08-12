import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/review/model/customer_review_list_shop_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/view/s_kyc_approved.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/view/s_kyc_completed.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_my_subscription/model/get_subscription_history_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_my_subscription/view/s_my_subscription_plans_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/view/s_shop_configuration_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/model/s_buy_subscription_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/model/s_subscription_plans_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/repository/s_buy_subscription_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/repository/subscription_plan_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/view/s_subscription_view.dart';
import 'package:local_supper_market/screen/shop_owner/shop_review/model/shop_review_model.dart';
import 'package:local_supper_market/screen/shop_owner/shop_review/repository/shop_review_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SShopReviewListController extends ChangeNotifier {
  ShopReviewListRepo shopReviewListRepo = ShopReviewListRepo();
  List<ReviewList>? reviewList;
  ShopDetails? shopDetails;
  Data? data;
  bool isLoading = false;

  Future<void> initState(context) async {
    await getShopReviewList(context);
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getShopReviewList(context) async {
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    shopReviewListRepo
        .shopReview(pref.getString("successToken"))
        .then((response) {
      print("successToken");
      final result = ShopReviewListModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        data = result.data;
        reviewList = data?.reviewList;
        // subscriptionData = result.subscriptionData;
        // addOnServicesList = result.addOnServicesList;

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
}
