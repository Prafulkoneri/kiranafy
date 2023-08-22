import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_supper_market/main.dart';
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_my_subscription/model/get_subscription_history_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_my_subscription/model/subscription_invoice_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_my_subscription/repository/get_subscription_history_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_my_subscription/repository/subscription_invoice_repo.dart';

import 'package:local_supper_market/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubscriptionHistoryController extends ChangeNotifier {
  SubscriptionHistoryRepo subscriptionHistoryRepo = SubscriptionHistoryRepo();
  SubScreptionInvoiceRepo subscreptionInvoicesRepo = SubScreptionInvoiceRepo();
  bool isLoading = true;
  SubcriptionData? subscriptiondata;
  CurrentSubscriptionPlan? currentSubscriptionPlan;
  List<SubscriptionHistory>? subscriptionHistory;
  ShopInvoiceList? shopInvoiceList;
  SubscriptionInvoiceData? subscriptioninvoicedata;
  int selectedIndex = 0;
  int count = 1;
  String subscreptionId = "";
  Directory? directory;
  String fileurl ="";

  Future<void> initState(
    context,
  ) async {
    await getSubscriptionPaymentHistory(
      context,
    );
    notifyListeners();
  }

  Future<void> _showNotification(fileName,savePath) async {
    final android = AndroidNotificationDetails('0', 'Adun Accounts',
        channelDescription: 'channel description',
        importance: Importance.max,
        icon: '');
    final iOS = IOSNotificationDetails();
    final platform = NotificationDetails(android: android, iOS: iOS);

    await flutterLocalNotificationsPlugin.show(
        0, // notification id
        "${fileName}",
        'Download complete.',
        platform,
        payload: '$savePath');
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getSubscriptionPaymentHistory(context) async {
    showLoader(true);
    print("loading");
    SharedPreferences pref = await SharedPreferences.getInstance();
    subscriptionHistoryRepo
        .subscriptionHistory(pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result =
          GetSubscriptionHistoryModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        subscriptiondata = result.subscriptiondata;
        currentSubscriptionPlan = subscriptiondata?.currentSubscriptionPlan;
        subscriptionHistory = subscriptiondata?.subscriptionHistory;
        showLoader(false);
        notifyListeners();
      } else {
        showLoader(false);
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
  ShopConfigrationInvoiceRequestModel get subscreiptionInvoicesReqModel =>
      ShopConfigrationInvoiceRequestModel(subscriptionId: subscreptionId);

  Future<void> subscriptionInvoice(context, subId) async {
    subscreptionId = subId;
    // getDownloadPath();

    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    subscreptionInvoicesRepo
        .subscriptionInvoice(
            subscreiptionInvoicesReqModel, pref.getString("successToken"))
        .then((response) async {
      log(response.body);
      final result =
          ShopConfigrationInvoiceResModel.fromJson(jsonDecode(response.body));
      log(response.body);
      if (response.statusCode == 200) {
        subscriptioninvoicedata = result.subscriptioninvoicedata;
        Map<Permission, PermissionStatus> statuses = await [
          Permission.storage,
          //add more permission to request here.
        ].request();
        var dir;
        if (Platform.isIOS) {
          dir = await getApplicationDocumentsDirectory();
        } else {
          Directory tempDir = await getTemporaryDirectory();
          dir = Directory(tempDir.path);
        }

        if (dir != null) {
          String fullPath=subscriptioninvoicedata?.shopInvoiceList?.invoiceLink.toString()??"";
          List splitPath = fullPath.split("/");
          print(splitPath);
          String saveName=splitPath[splitPath.length-1];
          print("savename${saveName}");
          String savePath = dir.path + "/$saveName";
          print("Save path");
          print(savePath);
          fileurl=Endpoint.baseUrl.toString().substring(0,Endpoint.baseUrl.toString().length-4).toString()+"${subscriptioninvoicedata?.shopInvoiceList?.invoiceLink.toString()}";
         print("FileUrl");
          print(fileurl);
          print("Invoice Link");
          String invoicePath=subscriptioninvoicedata?.shopInvoiceList?.invoiceLink.toString()??"";
          print(subscriptioninvoicedata?.shopInvoiceList?.invoiceLink.toString());
          //output:  /storage/emulated/0/Download/banner.png

          try {
            await Dio().download(fileurl, savePath,
                onReceiveProgress: (received, total) {
              if (total != -1) {
                print((received / total * 100).toStringAsFixed(0) + "%");
                //you can build progressbar feature too
              }
            });
            print("File is saved to download folder.");
          } on DioError catch (e) {
            Utils.showPrimarySnackbar(context,"Invalid Url",
                type: SnackType.error);
            return;
          }
          print(saveName);
          _showNotification(saveName,savePath);
        }
        print("No permission to read and write.");
        print(directory?.path.toString());
        print("jjjjjjjjjjjjjjjjjjjjjjjjjjjjj");

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
