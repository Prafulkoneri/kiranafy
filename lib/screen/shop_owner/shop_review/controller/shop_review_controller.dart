import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/review/model/customer_review_list_shop_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/screen/shop_owner/shop_review/model/shop_review_model.dart';
import 'package:local_supper_market/screen/shop_owner/shop_review/repository/shop_review_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
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
      log(response.body);
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
      } else if (response.statusCode == 401) {
        Utils().logoutUser(context);
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
