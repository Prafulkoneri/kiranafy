import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/order_status/model/track_order_status_model.dart';
import 'package:local_supper_market/screen/customer/order_status/repository/track_order_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrackOrderStatusController extends ChangeNotifier {
  String orderId = "";
  TrakOrderRepo trackOrderRepo = TrakOrderRepo();
  TrackOrderRequestodel get trackOrderReqModel => TrackOrderRequestodel(
        orderId: orderId.toString(),
      );
  Future<void> initState(context, orId) async {
    await trackOrderStatus(context, orId);
  }

  Future<void> trackOrderStatus(context, orId) async {
    orderId = orId.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    trackOrderRepo
        .trackOrder(trackOrderReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = TrackOrderResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
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
