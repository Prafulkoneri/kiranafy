import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  String fileurl =
      "https://localsupermart.com/testing/storage/subscription_pdf_invoice/LSMSUBS000054-2023-08-0810:50:38.pdf";

  Future<void> initState(
    context,
  ) async {
    await getSubscriptionPaymentHistory(
      context,
    );
    notifyListeners();
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
        .then((response) {
      log(response.body);
      final result =
          ShopConfigrationInvoiceResModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        // subscriptioninvoicedata = result.subscriptioninvoicedata;
        // shopInvoiceList = subscriptioninvoicedata?.shopInvoiceList;
        // downloadFile(
        //     "https://localsupermart.com/testing/storage/subscription_pdf_invoice/LSMSUBS000054-2023-08-0810:50:38.pdf" ??
        //     "",
        // "subscreptionPdf",
        // directory?.path.toString() ?? "");
        // customerDetail = result.data;
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

  //////////////////
  // Future<String> downloadFile(String url, String fileName, String dir) async {
  //   HttpClient httpClient = new HttpClient();
  //   File file;
  //   String filePath = '';
  //   String myUrl = '';

  //   try {
  //     myUrl = url;
  //     var request = await httpClient.getUrl(Uri.parse(myUrl));

  //     var response = await request.close();

  //     if (response.statusCode == 200) {
  //       var bytes = await consolidateHttpClientResponseBytes(response);
  //       filePath = '$dir/$fileName';
  //       file = File(filePath);
  //       await file.writeAsBytes(bytes);
  //     } else
  //       filePath = 'Error code: ' + response.statusCode.toString();
  //   } catch (ex) {
  //     filePath = 'Can not fetch url';
  //   }

  //   return filePath;
  // }

  // ///////
  // Future<String?> getDownloadPath() async {
  //   try {
  //     if (Platform.isIOS) {
  //       directory = await getApplicationDocumentsDirectory();
  //     } else {
  //       directory = Directory('/storage/emulated/0/Download');
  //       // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
  //       // ignore: avoid_slow_async_io
  //       if (!await directory!.exists())
  //         directory = await getExternalStorageDirectory();
  //     }
  //   } catch (err, stack) {
  //     print("Cannot get download folder path");
  //   }
  //   return directory?.path;
  // }

  ////////////
//   Future<String?> saveFileToDevice(
//       context, String filename, List<int> data) async {
// // Get the path to the app's documents directory
//     var status = await Permission.storage.status;
//     if (!status.isGranted) {
//       await Permission.storage.request();
//     }

//     var dir = Platform.isAndroid
//         ? '/storage/emulated/0/Download'
//         : (await getApplicationDocumentsDirectory()).path;

// // Create the file and write the data to it
//     var file = File('$dir/$filename');

//     bool alreadyDownloaded = await file.exists();

//     String incrementCount(String fileName) {
//       int dotIndex = fileName.lastIndexOf('.');
//       String newFileName = fileName.substring(0, dotIndex) +
//           "(${count += 1})" +
//           fileName.substring(dotIndex);

//       return newFileName;
//     }

//     if (alreadyDownloaded) {
//       String newFileName = incrementCount(file.path);

//       var newFile = File('$newFileName');
//       await newFile.writeAsBytes(data, flush: true);

//       String subStringFileName = newFileName.substring(29);
//       Utils.showPrimarySnackbar(context, "Saved File", type: SnackType.error);

//       //  Utils.showPrimarySnackbar(context, result.message,
//       //           type: SnackType.error);

//       file = newFile;
//       print('modified updating ....--> $file');
//     } else {
//       await file.writeAsBytes(data, flush: true);

//       // CommonWidgets.makeToast(
//       //     fontSize: 14, toastMsg: '${filename} saved to Downloads Folder');
//       Utils.showPrimarySnackbar(context, "saved to Downloads Folder",
//           type: SnackType.error);
//     }

//     return 'file://${file.path}';
//   }
}
