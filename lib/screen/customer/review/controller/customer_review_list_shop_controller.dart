import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/cart/view/cart_screen_view.dart';
import 'package:local_supper_market/screen/customer/delivery_view/model/customer_cancel_order_model.dart';
import 'package:local_supper_market/screen/customer/delivery_view/model/get_cancel_order_model.dart';

import 'package:local_supper_market/screen/customer/delivery_view/model/order_view_model.dart';
import 'package:local_supper_market/screen/customer/delivery_view/model/order_view_model.dart';
import 'package:local_supper_market/screen/customer/delivery_view/model/reorder_model.dart';
import 'package:local_supper_market/screen/customer/delivery_view/model/submit_review_model.dart';
import 'package:local_supper_market/screen/customer/delivery_view/repository/customer_cancel_order_repo.dart';
import 'package:local_supper_market/screen/customer/delivery_view/repository/get_cancel_order_view_repo.dart';

import 'package:local_supper_market/screen/customer/delivery_view/repository/order_view_repo.dart';
import 'package:local_supper_market/screen/customer/delivery_view/repository/reorder_repo.dart';
import 'package:local_supper_market/screen/customer/delivery_view/repository/submit_review_repo.dart';
import 'package:local_supper_market/screen/customer/review/model/customer_review_list_shop_model.dart';
import 'package:local_supper_market/screen/customer/review/repository/customer_review_list_shop_repository.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';

import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerReviewListControler extends ChangeNotifier {
  String shopId = "";
  ShopReviewlistData? reviewlistData;
  List<ReviewList>? reviewList;
  ShopDetails? shopDetails;
  ShopReviewListRepo shopReviewListRepo = ShopReviewListRepo();

  //////////////

  Future<void> initState(context, sId) async {
    ShopReviewList(context, sId);
    notifyListeners();
  }

  /////////////////////////////////////////////////////////////////////////////////////////////

  CustomerShopReviewListRequestModel get customerShopReviewListRequestModel =>
      CustomerShopReviewListRequestModel(
        shopId: shopId.toString(),
      );
  Future<void> ShopReviewList(context, sId) async {
    print("object");
    print(sId);
    print("object1111111111111111111111");
    shopId = sId.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    shopReviewListRepo
        .shopReviewList(
            customerShopReviewListRequestModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = CustomerGetShopReviewListResponseModel.fromJson(
          jsonDecode(response.body));
      if (response.statusCode == 200) {
        reviewlistData = result.reviewlistData;
        print(reviewlistData?.shopDetails);
        reviewList = reviewlistData?.reviewList;
        shopDetails = reviewlistData?.shopDetails;
        print(shopDetails?.shopAddress);

        print("22222222222222222222222222222");
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

///////////////////////////////////////////////////////////////////////////////////
}
