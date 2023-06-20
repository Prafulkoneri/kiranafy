import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_supper_market/screen/customer/my_order/model/my_order_model.dart';
import 'package:local_supper_market/screen/customer/my_order/repository/my_order_repo.dart';

import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyOrdersController extends ChangeNotifier {
  MyOrdersRepo myOrderRepo = MyOrdersRepo();
  String? shopId = "";
  String? orderStatus = "";

  MyOrdersRequestModel get myOrderRequestModel => MyOrdersRequestModel(
      shopId: shopId.toString(), orderStatus: orderStatus.toString());
  Future<void> getOrderSummary(context, id, orStatus) async {
    shopId = id.toString();
    orderStatus = orStatus.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    myOrderRepo
        .myOrders(myOrderRequestModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = MyOrdersResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
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
