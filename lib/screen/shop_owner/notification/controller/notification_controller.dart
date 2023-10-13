import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/notifications/model/delete_notification_model.dart';
import 'package:local_supper_market/screen/shop_owner/notification/model/get_notification_model.dart';
import 'package:local_supper_market/screen/shop_owner/notification/repository/get_notification_repo.dart';
import 'package:local_supper_market/screen/shop_owner/notification/repository/s_delete_notification_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopNoticationController extends ChangeNotifier {
  bool isLoading = true;
  NotificationData? notificationdata;
  List<NotificationList>? notificationList;

  NOtificationRepo ticketReplyRepo = NOtificationRepo();
  SDeleteNotificationRepo sDeleteNotificationRepo = SDeleteNotificationRepo();
  Future<void> initState(context) async {
    await getNotificationList(context);
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  ////////////////////////////////Ticket Type/////////////////////////////
  Future<void> getNotificationList(context) async {
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    ticketReplyRepo
        .notificationList(pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result = NotificationModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        notificationdata = result.notificationdata;
        notificationList = notificationdata?.notificationList;
        showLoader(false);
        notifyListeners();
      }
      else if(response.statusCode == 401){
        Utils().logoutUser(context);
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

  ///////////////////////////////////////////////
  Future<void> sDeleteNotification(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    sDeleteNotificationRepo
        .sdeleteNotification(pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result = CNotificationModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        if(result.status==200) {
          notificationList?.clear();
          notifyListeners();
        }
        else{

          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
        }
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
