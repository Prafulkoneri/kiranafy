import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/cart/view/cart_screen_view.dart';
import 'package:local_supper_market/screen/customer/delivery_view/model/customer_cancel_order_model.dart';
import 'package:local_supper_market/screen/customer/delivery_view/model/get_cancel_order_model.dart';
import 'package:local_supper_market/screen/customer/delivery_view/model/get_shop_review_model.dart';
import 'package:local_supper_market/screen/customer/delivery_view/model/order_view_model.dart';
import 'package:local_supper_market/screen/customer/delivery_view/model/order_view_model.dart';
import 'package:local_supper_market/screen/customer/delivery_view/model/reorder_model.dart';
import 'package:local_supper_market/screen/customer/delivery_view/model/submit_review_model.dart';
import 'package:local_supper_market/screen/customer/delivery_view/repository/customer_cancel_order_repo.dart';
import 'package:local_supper_market/screen/customer/delivery_view/repository/get_cancel_order_view_repo.dart';
import 'package:local_supper_market/screen/customer/delivery_view/repository/get_shop_review_list_repo.dart';
import 'package:local_supper_market/screen/customer/delivery_view/repository/order_view_repo.dart';
import 'package:local_supper_market/screen/customer/delivery_view/repository/reorder_repo.dart';
import 'package:local_supper_market/screen/customer/delivery_view/repository/submit_review_repo.dart';
import 'package:local_supper_market/screen/customer/review/model/customer_review_list_shop_model.dart';
import 'package:local_supper_market/screen/customer/review/repository/customer_review_list_shop_repository.dart';

import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerOrderViewController extends ChangeNotifier {
  String shopId = "";

  ShopReviewListRepo shopReviewListRepo = ShopReviewListRepo();

  //////////////

  Future<void> initState(
    context,
  ) async {
    notifyListeners();
  }

  /////////////////////////////////////////////////////////////////////////////////////////////

  CustomerShopReviewListRequestModel get customerShopReviewListRequestModel =>
      CustomerShopReviewListRequestModel(
        shopId: shopId.toString(),
      );
  Future<void> ShopReviewList(context, sId) async {
    LoadingOverlay.of(context).show();
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
        print("hello");
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
        LoadingOverlay.of(context).hide();

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
