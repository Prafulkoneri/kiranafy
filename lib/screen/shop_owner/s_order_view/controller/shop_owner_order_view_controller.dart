// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:local_supper_market/main.dart';
// import 'package:local_supper_market/network/end_points.dart';
// import 'package:local_supper_market/screen/customer/delivery_view/model/order_invoice_download_model.dart';
// import 'package:local_supper_market/screen/customer/delivery_view/repository/order_invoiec_repo.dart';
// import 'package:local_supper_market/screen/shop_owner/payment_refund/view/payment_refund_view.dart';
// import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
// import 'package:local_supper_market/screen/shop_owner/s_order_status/view/s_order_status_view.dart';
// import 'package:local_supper_market/screen/shop_owner/s_order_view/model/cancel_model.dart';
// import 'package:local_supper_market/screen/shop_owner/s_order_view/model/order_status_mode.dart';
// import 'package:local_supper_market/screen/shop_owner/s_order_view/model/remove_product_from_order.dart';
// import 'package:local_supper_market/screen/shop_owner/s_order_view/model/shop_owner_delivered_refund_submit_model.dart';
// import 'package:local_supper_market/screen/shop_owner/s_order_view/model/shop_owner_model.dart';
// import 'package:local_supper_market/screen/shop_owner/s_order_view/model/shop_update_refund_model.dart';
// import 'package:local_supper_market/screen/shop_owner/s_order_view/repository/add_remove_product_from_order_repo.dart';
// import 'package:local_supper_market/screen/shop_owner/s_order_view/repository/cancel_reason_repo.dart';
// import 'package:local_supper_market/screen/shop_owner/s_order_view/repository/order_status_repo.dart';
// import 'package:local_supper_market/screen/shop_owner/s_order_view/repository/shop_owner_delivered_refund_submit_repo.dart';
// import 'package:local_supper_market/screen/shop_owner/s_order_view/repository/shop_owner_order_repo.dart';
// import 'package:local_supper_market/screen/shop_owner/s_order_view/repository/shop_update_refund_repo.dart';

// import 'package:local_supper_market/screen/shop_owner/s_products/model/shop_add_product_list_model.dart';

// import 'package:local_supper_market/utils/Utils.dart';
// import 'package:local_supper_market/widget/loaderoverlay.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ShopOwnerOrderViewController extends ChangeNotifier {
//   String orderId = "";
//   String deliveryCode = "";
//   String orderStatus = "";
//   String orderCancelledReason = "";
//   String orderCancelledReasonId = "";
//   String deliveryCodeError = "";
//   String subTotal = "0";
//   String totalDiscount = "0";
//   String deliveryCharges = "0";
//   String totalAmount = "0";
//   OrderInvoiceData? orderinvoicedata;
//   String fileurl = "";
//   Directory? directory;
//   // String? deliveryCode = "";
//   TextEditingController reasonController = TextEditingController();
//   bool isDeliveryCodeError = false;
//   bool isLoading = true;
//   bool isStackLoading = false;
//   List<bool> isSelectedReason = [];
//   bool isOtherReasonSelected = false;
//   ShopOrderViewData? shopOrderViewData;
//   OrderDetails? orderDetails;
//   CouponDetails? couponDetails;
//   DeliveryAddressDetails? deliveryAddressDetails;
//   List<OrderProductDetail>? orderProductDetails;
//   ShopOrderViewRepo shopOrderViewRepo = ShopOrderViewRepo();
//   OrderCancelReasonRepo orderCancelReasonRepo = OrderCancelReasonRepo();
//   AddRemoveProductFromOrderRepo addRemoveProductFromOrderRepo =
//       AddRemoveProductFromOrderRepo();
//   List<CancelReasonList>? cancelReasondata;
//   String cancelOrderErrorMsg = "";
//   bool isCancelOrderErrorMsgVisible = false;
//   String cancellationId = "";
//   String productId = "";
//   String totalRefundAmount = "0";
//   List<bool> selectedProductList = [];
//   bool acceptPayment = false;
//   bool rejectPayment = false;
//   bool isRefundByCash = false;
//   bool isRefundByUpi = false;
//   TextEditingController upiIdController = TextEditingController();
//   TextEditingController rejectReasonController = TextEditingController();
//   TextEditingController refundPayableAmount = TextEditingController();
//   OrderInvoiceRepo orderInvoicerepo = OrderInvoiceRepo();
//   OrderInvoiceRepo orderInvoiceRepo = OrderInvoiceRepo();
//   ShopUpdateDeliveredRefundRepo shopUpdateDeliveredRefundRepo =
//       ShopUpdateDeliveredRefundRepo();

//   ShopOrderViewRequestModel get shopOrderViewReqModel =>
//       ShopOrderViewRequestModel(orderId: orderId.toString());

//   //////////////
//   ShopOwnerOrderStatusChangedRepo orderStatusChangedRepo =
//       ShopOwnerOrderStatusChangedRepo();

//   ShopUpdateRefundRepo shopUpdateRefundRepo = ShopUpdateRefundRepo();

//   OrderStatusChangeRequestModel get orderStatusChangedRequestModel =>
//       OrderStatusChangeRequestModel(
//           orderId: orderId.toString(),
//           orderStatus: orderStatus.toString(),
//           orderCancelledReason: orderCancelledReason.toString(),
//           orderCancelledReasonId: orderCancelledReasonId.toString(),
//           deliveryCode: deliveryCode.toString());

//   Future<void> initState(
//     context,
//     orId,
//   ) async {
//     orderId = "";
//     orderStatus = "";
//     orderCancelledReason = "";
//     orderCancelledReasonId = "";
//     deliveryCode = "";
//     reasonController.clear();
//     rejectReasonController.clear();
//     acceptPayment = false;
//     rejectPayment = false;
//     isRefundByCash = false;
//     isRefundByUpi = false;
//     upiIdController.clear();
//     refundPayableAmount.clear();
//     await shopOwnerOrderView(context, orId, true);

//     getCancelOrderList(context);
//     notifyListeners();
//   }

//   void showLoader(value) {
//     isLoading = value;
//     print("loading........${isLoading}");
//     notifyListeners();
//   }

//   Future<void> shopOwnerOrderView(context, orId, showLoading) async {
//     if (showLoading) {
//       showLoader(true);
//     }
//     selectedProductList.clear();
//     orderId = orId.toString();
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     shopOrderViewRepo
//         .shopOrderView(shopOrderViewReqModel, pref.getString("successToken"))
//         .then((response) async {
//       log(response.body);
//       final result = ShopOrderViewResModel.fromJson(jsonDecode(response.body));
//       if (response.statusCode == 200) {
//         shopOrderViewData = result.shopOrderViewData;
//         orderDetails = shopOrderViewData?.orderDetails;
//         couponDetails = shopOrderViewData?.couponDetails;
//         deliveryAddressDetails = shopOrderViewData?.deliveryAddressDetails;
//         orderProductDetails = shopOrderViewData?.orderProductDetails;
//         subTotal = orderDetails?.subTotal ?? "";
//         totalAmount = orderDetails?.totalAmount ?? "";
//         deliveryCharges = orderDetails?.deliveryCharges ?? "";
//         totalDiscount = orderDetails?.totalDiscount ?? "";
//         totalRefundAmount = shopOrderViewData?.orderRefundAmount ?? "0";
//         selectedProductList = List<bool>.filled(
//             orderProductDetails?.length ?? 0, false,
//             growable: true);
//         int productListLength = orderProductDetails?.length ?? 0;
//         for (int i = 0; i < productListLength; i++) {
//           if (orderProductDetails?[i].status == "active") {
//             selectedProductList.removeAt(i);
//             selectedProductList.insert(i, true);
//           } else {
//             selectedProductList.removeAt(i);
//             selectedProductList.insert(i, false);
//           }
//         }
//         print("selectedProductList${selectedProductList}");
//         if (orderDetails?.shopOwnerRefundStatus == "pending") {
//           if (orderDetails?.customerCancelledStatus == "YES" ||
//               orderDetails?.shopOwnerCancelledStatus == "YES") {
//             acceptPayment = true;
//           }
//         }

//         await getCancelOrderList(context);
//         if (showLoading) {
//           showLoader(false);
//         } else {
//           showLoader(true);
//         }

//         notifyListeners();
//       } else {
//         Utils.showPrimarySnackbar(context, result.message,
//             type: SnackType.error);
//       }
//     }).onError((error, stackTrace) {
//       Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
//     }).catchError(
//       (Object e) {
//         Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
//       },
//       test: (Object e) {
//         Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
//         return false;
//       },
//     );
//   }

//   OrderInvoiceRequestModel get orderInvoiceRequestModel =>
//       OrderInvoiceRequestModel(orderId: orderId.toString());

//   Future<void> orderInvoice(context) async {
//     // orderId = oId;
//     // getDownloadPath();

//     SharedPreferences pref = await SharedPreferences.getInstance();
//     print(pref.getString("successToken"));
//     orderInvoicerepo
//         .orderInvoice(orderInvoiceRequestModel, pref.getString("successToken"))
//         .then((response) async {
//       log(response.body);
//       final result = OrderInvoiceResModel.fromJson(jsonDecode(response.body));
//       print(response.statusCode);
//       if (response.statusCode == 200) {
//         orderinvoicedata = result.orderinvoiecdata;
//         Map<Permission, PermissionStatus> statuses = await [
//           Permission.storage,
//           //add more permission to request here.
//         ].request();
//         var dir;
//         if (Platform.isIOS) {
//           dir = await getApplicationDocumentsDirectory();
//         } else {
//           Directory tempDir = await getTemporaryDirectory();
//           dir = Directory(tempDir.path);
//         }

//         if (dir != null) {
//           String fullPath =
//               orderinvoicedata?.customerInvoiceList?.invoiceLink.toString() ??
//                   "";
//           List splitPath = fullPath.split("/");
//           print(splitPath);
//           String saveName = splitPath[splitPath.length - 1];
//           print("savename${saveName}");
//           String savePath = dir.path + "/$saveName";
//           print(savePath);
//           fileurl = Endpoint.baseUrl
//                   .toString()
//                   .substring(0, Endpoint.baseUrl.toString().length - 4)
//                   .toString() +
//               "${orderinvoicedata?.customerInvoiceList?.invoiceLink.toString()}";
//           //output:  /storage/emulated/0/Download/banner.png

//           try {
//             await Dio().download(fileurl, savePath,
//                 onReceiveProgress: (received, total) {
//               if (total != -1) {
//                 print((received / total * 100).toStringAsFixed(0) + "%");
//                 //you can build progressbar feature too
//               }
//             });
//             print("File is saved to download folder.");
//           } on DioError catch (e) {
//             print(e.message);
//             Utils.showPrimarySnackbar(context, "Invalid Url",
//                 type: SnackType.error);
//             return;
//           }
//           _showNotification(saveName, savePath);
//         }
//         print("No permission to read and write.");
//         print(directory?.path.toString());
//         print("jjjjjjjjjjjjjjjjjjjjjjjjjjjjj");

//         notifyListeners();
//       } else {
//         Utils.showPrimarySnackbar(context, result.message,
//             type: SnackType.error);
//       }
//     }).onError((error, stackTrace) {
//       Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
//     }).catchError(
//       (Object e) {
//         Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
//       },
//       test: (Object e) {
//         Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
//         return false;
//       },
//     );
//   }

//   Future<void> _showNotification(fileName, savePath) async {
//     final android = AndroidNotificationDetails('0', 'Adun Accounts',
//         channelDescription: 'channel description',
//         importance: Importance.max,
//         icon: '');
//     final iOS = IOSNotificationDetails();
//     final platform = NotificationDetails(android: android, iOS: iOS);

//     await flutterLocalNotificationsPlugin.show(
//         0, // notification id
//         "${fileName}",
//         'Download complete.',
//         platform,
//         payload: '$savePath');
//   }

//   Future<void> shopOrderStatus(
//       context, orId, oStatus, oCReason, oCReasonId, dCode) async {
//     orderId = orId.toString();
//     orderStatus = oStatus.toString();
//     orderCancelledReason = oCReason.toString();
//     orderCancelledReasonId = oCReasonId.toString();
//     deliveryCode = dCode.toString();

//     if (oStatus == "order_confirmed") {
//       List checkDataList = [];
//       for (int i = 0; i < selectedProductList.length; i++) {
//         print(selectedProductList);
//         if (selectedProductList[i] == true) {
//           checkDataList.add(selectedProductList[i]);
//         }
//         print(checkDataList);
//       }
//       if (checkDataList.isEmpty) {
//         Utils.showPrimarySnackbar(context, "No product selected",
//             type: SnackType.error);
//         return;
//       }
//     }

//     if (oStatus == "order_cancelled") {
//       if (!isOtherReasonSelected && orderCancelledReasonId == "") {
//         cancelOrderErrorMsg = "Please Enter reason for cancellation";
//         isCancelOrderErrorMsgVisible = true;
//         notifyListeners();
//         Timer(Duration(seconds: 3), () {
//           isCancelOrderErrorMsgVisible = false;
//           notifyListeners();
//         });
//         return;
//       }
//       if (orderCancelledReason == "") {
//         cancelOrderErrorMsg = "Please Enter reason for cancellation";
//         isCancelOrderErrorMsgVisible = true;
//         notifyListeners();
//         Timer(Duration(seconds: 3), () {
//           isCancelOrderErrorMsgVisible = false;
//           notifyListeners();
//         });
//         return;
//       }
//     }

//     showLoader(true);
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     orderStatusChangedRepo
//         .orderStatus(
//             orderStatusChangedRequestModel, pref.getString("successToken"))
//         .then((response) async {
//       final result =
//           OrderStatusChangeResModel.fromJson(jsonDecode(response.body));
//       if (response.statusCode == 200) {
//         if (oStatus == "order_cancelled") {
//           await shopOwnerOrderView(context, orId, true);
//           // Navigator.pushAndRemoveUntil(
//           //   context,
//           //   MaterialPageRoute(
//           //       builder: (context) => SMainScreenView(
//           //           index: 1,
//           //           screenName: SOrderStatusView(
//           //             selectedIndex: 4,
//           //             isFromOrderView: true,
//           //           ))),
//           //   (Route<dynamic> route) => false,
//           // );
//         }
//         if (result.message != "Delivery code not matched. Please try again.") {
//           print("dafaadadasd");
//           await shopOwnerOrderView(context, orId, true);
//           isDeliveryCodeError = false;
//           if (oStatus == "order_delivered") {
//             Navigator.pop(context);
//           }
//           if (oStatus == "order_cancelled") {
//             Navigator.pop(context);
//           }
//         } else {
//           showLoader(false);
//           deliveryCodeError = result.message ?? "";
//           isDeliveryCodeError = true;
//           notifyListeners();
//           Timer(Duration(seconds: 3), () {
//             isDeliveryCodeError = false;
//             notifyListeners();
//           });
//         }
//         notifyListeners();
//       } else {
//         Utils.showPrimarySnackbar(context, result.message,
//             type: SnackType.error);
//       }
//     }).onError((error, stackTrace) {
//       Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
//     }).catchError(
//       (Object e) {
//         Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
//       },
//       test: (Object e) {
//         Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
//         return false;
//       },
//     );
//   }

//   Future<void> getCancelOrderList(context) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     orderCancelReasonRepo.OrderCancelReason(pref.getString("successToken"))
//         .then((response) {
//       log(response.body);
//       final result = CancelModel.fromJson(jsonDecode(response.body));
//       if (response.statusCode == 200) {
//         cancelReasondata = result.cancelReasondata;
//         int cancelOrderLength = cancelReasondata?.length ?? 0;
//         isSelectedReason = List<bool>.filled(cancelOrderLength, false);
//         notifyListeners();
//       } else {
//         Utils.showPrimarySnackbar(context, result.message,
//             type: SnackType.error);
//       }
//     }).onError((error, stackTrace) {
//       Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
//     }).catchError(
//       (Object e) {
//         Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
//       },
//       test: (Object e) {
//         Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
//         return false;
//       },
//     );
//   }

//   // void onSelectReason(value) {
//   //   if (!isSelectedReason) {
//   //     isSelectedReason = true;

//   //   } else {
//   //     isSelectedReason = false;
//   //   }
//   //   notifyListeners();
//   // }

//   void onSelectReason(index, value, id) {
//     if (isSelectedReason[index]) {
//       isSelectedReason[index] = false;
//       cancellationId = "";
//       notifyListeners();
//       return;
//     }
//     int cancelOrderLength = cancelReasondata?.length ?? 0;

//     isSelectedReason =
//         List<bool>.filled(cancelOrderLength, false, growable: true);
//     isSelectedReason[index] = true;
//     cancellationId = id.toString();
//     isOtherReasonSelected = false;

//     // isSelectedReason[index]=true;

//     notifyListeners();
//   }

//   void onOtherSelected(value) {
//     if (isOtherReasonSelected) {
//       isOtherReasonSelected = false;
//       notifyListeners();
//       return;
//     }
//     int cancelOrderLength = cancelReasondata?.length ?? 0;
//     isSelectedReason =
//         List<bool>.filled(cancelOrderLength, false, growable: true);
//     isOtherReasonSelected = true;
//     notifyListeners();
//   }

//   void onCancelErrorMissageDismiss() {
//     isCancelOrderErrorMsgVisible = false;
//     notifyListeners();
//   }

//   Future<void> onDeliveryCode(code) async {
//     deliveryCode = code;
//     notifyListeners();
//   }

//   void onCodeDismiss() {
//     isDeliveryCodeError = false;
//     notifyListeners();
//   }

//   AddRemoveProductFromOrderReqModel get addRemoveProductFromOrderReqModel =>
//       AddRemoveProductFromOrderReqModel(
//         orderProductId: productId,
//       );

//   Future<void> selectProducts(context, index, id, value) async {
//     LoadingOverlay.of(context).show();

//     productId = id.toString();
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     addRemoveProductFromOrderRepo
//         .addremoveProductFromOrder(
//             addRemoveProductFromOrderReqModel, pref.getString("successToken"))
//         .then((response) {
//       log(response.body);
//       final result =
//           AddRemoveProductFromOrderResModel.fromJson(jsonDecode(response.body));
//       if (response.statusCode == 200) {
//         if (selectedProductList[index]) {
//           selectedProductList.removeAt(index);
//           selectedProductList.insert(index, false);
//         } else {
//           selectedProductList.removeAt(index);
//           selectedProductList.insert(index, true);
//         }

//         totalDiscount = result.data?.totalDiscount.toString() ?? "";
//         totalAmount = result.data?.totalAmount.toString() ?? "";
//         subTotal = result.data?.subTotalAmount.toString() ?? "";
//         deliveryCharges = result.data?.deliveryCharges.toString() ?? "";

//         totalRefundAmount = result.data?.totalRefundAmount.toString() ?? "";

//         LoadingOverlay.of(context).hide();
//         notifyListeners();
//       } else {
//         Utils.showPrimarySnackbar(context, result.message,
//             type: SnackType.error);
//       }
//     }).onError((error, stackTrace) {
//       Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
//     }).catchError(
//       (Object e) {
//         Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
//       },
//       test: (Object e) {
//         Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
//         return false;
//       },
//     );
//   }

//   void onRefundAccept() {
//     acceptPayment = true;
//     rejectPayment = false;
//     notifyListeners();
//   }

//   void onRefundReject() {
//     acceptPayment = false;
//     rejectPayment = true;
//     notifyListeners();
//   }

//   void onRefundByCash(value) {
//     if (!isRefundByCash) {
//       isRefundByCash = true;
//       isRefundByUpi = false;
//     } else {
//       isRefundByCash = false;
//       isRefundByUpi = false;
//     }
//     notifyListeners();
//   }

//   void onRefundByUpi(value) {
//     if (!isRefundByUpi) {
//       isRefundByUpi = true;
//       isRefundByCash = false;
//     } else {
//       isRefundByCash = false;
//       isRefundByUpi = false;
//     }
//     notifyListeners();
//   }

//   ShopUpdateRefundReqModel get shopUpdateRefundReqModel =>
//       ShopUpdateRefundReqModel(
//         orderId: orderId,
//         refundOrderStatus: acceptPayment ? "accept" : "reject",
//         refundPaymentType: isRefundByCash ? "cash" : "upi",
//         refundRejectReason: rejectReasonController.text,
//         refunPayableAmount: refundPayableAmount.text,
//         transactionId: upiIdController.text,
//       );

//   Future<void> shopRefundUpdate(context) async {
//     if (acceptPayment) {
//       if (refundPayableAmount.text == "") {
//         Utils.showPrimarySnackbar(context, "Please Enter Refundable Amount",
//             type: SnackType.error);
//         return;
//       }
//       //   if (!isQrCodeSeleted & !isSelectedPaymentUpi) {
//       //   Utils.showPrimarySnackbar(context, "Please Select Mode Of Payment",
//       //       type: SnackType.error);
//       //   return;
//       // }
//       if (upiIdController.text == "") {
//         Utils.showPrimarySnackbar(context, "Please Enter Transaction ID",
//             type: SnackType.error);
//         return;
//       }
//       if (refundPayableAmount.text == "") {
//         Utils.showPrimarySnackbar(context, "Please Enter Refundable Amount",
//             type: SnackType.error);
//         return;
//       }
//       if (!isRefundByCash && !isRefundByUpi) {
//         Utils.showPrimarySnackbar(context, "Please Select Payment Method",
//             type: SnackType.error);
//         return;
//       }
//     } else {
//       if (rejectReasonController.text == "") {
//         Utils.showPrimarySnackbar(context, "Please Enter Reject Reason",
//             type: SnackType.error);
//         return;
//       }
//     }

//     LoadingOverlay.of(context).show();
//     print("loading");
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     shopUpdateRefundRepo
//         .shopUpdateRefund(
//             shopUpdateRefundReqModel, pref.getString("successToken"))
//         .then((response) {
//       log(response.body);
//       final result =
//           ShopUpdateRefundResModel.fromJson(jsonDecode(response.body));
//       if (response.statusCode == 200) {
//         LoadingOverlay.of(context).hide();
//         Utils.showPrimarySnackbar(context, result.message,
//             type: SnackType.success);
//         refundPayableAmount.clear();
//         upiIdController.clear();
//         reasonController.clear();

//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(
//               builder: (context) => SMainScreenView(
//                   index: 2,
//                   screenName: SPaymentRefundList(
//                     isNavFromAccounts: false,
//                   ))),
//           (Route<dynamic> route) => false,
//         );
//         notifyListeners();
//       } else {
//         LoadingOverlay.of(context).hide();
//         Utils.showPrimarySnackbar(context, result.message,
//             type: SnackType.error);
//       }
//     }).onError((error, stackTrace) {
//       LoadingOverlay.of(context).hide();
//       Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
//     }).catchError(
//       (Object e) {
//         LoadingOverlay.of(context).hide();
//         Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
//       },
//       test: (Object e) {
//         LoadingOverlay.of(context).hide();
//         Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
//         return false;
//       },
//     );
//   }

//   ShopOwnerDeliveredRefundSubmitReqModel
//       get shopOwnerDeliveredRefundSubmitReqModel =>
//           ShopOwnerDeliveredRefundSubmitReqModel(
//             orderId: orderId,
//             shopDeliveredRefundStatus: "YES",
//             shopDeliveredPaymentType: "upi",
//             shopDeliveredPayableAmount: refundPayableAmount.text,
//             shopDeliveredTransactionId: upiIdController.text,
//           );

//   Future<void> shopDeliveredRefundUpdate(context) async {
//     print(orderId);
//     print(refundPayableAmount.text);
//     print(upiIdController.text);

//     if (refundPayableAmount.text == "") {
//       Utils.showPrimarySnackbar(context, "Please Enter Refundable Amount",
//           type: SnackType.error);
//       return;
//     }
//     if (!isRefundByCash && !isRefundByUpi) {
//       Utils.showPrimarySnackbar(context, "Please Select Payment Method",
//           type: SnackType.error);
//       return;
//     }

//     LoadingOverlay.of(context).show();
//     print("loading");
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     shopUpdateDeliveredRefundRepo
//         .shopUpdateRefund(shopOwnerDeliveredRefundSubmitReqModel,
//             pref.getString("successToken"))
//         .then((response) {
//       log(response.body);
//       final result = ShopOwnerDeliveredRefundSubmitResModel.fromJson(
//           jsonDecode(response.body));
//       if (response.statusCode == 200) {
//         LoadingOverlay.of(context).hide();
//         Utils.showPrimarySnackbar(context, result.message,
//             type: SnackType.success);
//         refundPayableAmount.clear();
//         upiIdController.clear();
//         reasonController.clear();
//         shopOwnerOrderView(context, orderId, true);
//         notifyListeners();
//       } else {
//         LoadingOverlay.of(context).hide();
//         Utils.showPrimarySnackbar(context, result.message,
//             type: SnackType.error);
//       }
//     }).onError((error, stackTrace) {
//       LoadingOverlay.of(context).hide();
//       Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
//     }).catchError(
//       (Object e) {
//         LoadingOverlay.of(context).hide();
//         Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
//       },
//       test: (Object e) {
//         LoadingOverlay.of(context).hide();
//         Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
//         return false;
//       },
//     );
//   }

// ///////////////////////////////
// }
//////////////////////////////////4/9/2023//////////////////
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_supper_market/main.dart';
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/delivery_view/model/order_invoice_download_model.dart';
import 'package:local_supper_market/screen/customer/delivery_view/repository/order_invoiec_repo.dart';
import 'package:local_supper_market/screen/shop_owner/payment_refund/view/payment_refund_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_status/view/s_order_status_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/model/cancel_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/model/order_status_mode.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/model/remove_product_from_order.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/model/shop_owner_delivered_refund_submit_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/model/shop_owner_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/model/shop_update_refund_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/repository/add_remove_product_from_order_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/repository/cancel_reason_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/repository/order_status_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/repository/shop_owner_delivered_refund_submit_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/repository/shop_owner_order_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/repository/shop_update_refund_repo.dart';

import 'package:local_supper_market/screen/shop_owner/s_products/model/shop_add_product_list_model.dart';

import 'package:local_supper_market/utils/Utils.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopOwnerOrderViewController extends ChangeNotifier {
  String orderId = "";
  String deliveryCode = "";
  String orderStatus = "";
  String orderCancelledReason = "";
  String orderCancelledReasonId = "";
  String deliveryCodeError = "";
  String subTotal = "0";
  String totalDiscount = "0";
  String deliveryCharges = "0";
  String totalAmount = "0";
  OrderInvoiceData? orderinvoicedata;
  String fileurl = "";
  Directory? directory;
  // String? deliveryCode = "";
  TextEditingController reasonController = TextEditingController();
  bool isDeliveryCodeError = false;
  bool isLoading = true;
  bool isStackLoading = false;
  bool isDetailsAvailable = false;
  List<bool> isSelectedReason = [];
  bool isOtherReasonSelected = false;
  ShopOrderViewData? shopOrderViewData;
  OrderDetails? orderDetails;
  CouponDetails? couponDetails;
  DeliveryAddressDetails? deliveryAddressDetails;
  List<OrderProductDetail>? orderProductDetails;
  ShopOrderViewRepo shopOrderViewRepo = ShopOrderViewRepo();
  OrderCancelReasonRepo orderCancelReasonRepo = OrderCancelReasonRepo();
  AddRemoveProductFromOrderRepo addRemoveProductFromOrderRepo =
      AddRemoveProductFromOrderRepo();
  List<CancelReasonList>? cancelReasondata;
  String cancelOrderErrorMsg = "";
  bool isCancelOrderErrorMsgVisible = false;
  String cancellationId = "";
  String productId = "";
  String totalRefundAmount = "0";
  List<bool> selectedProductList = [];
  bool acceptPayment = false;
  bool rejectPayment = false;
  bool isRefundByCash = false;
  bool isRefundByUpi = false;
  TextEditingController upiIdController = TextEditingController();
  TextEditingController rejectReasonController = TextEditingController();
  TextEditingController refundPayableAmount = TextEditingController();
  OrderInvoiceRepo orderInvoicerepo = OrderInvoiceRepo();
  OrderInvoiceRepo orderInvoiceRepo = OrderInvoiceRepo();
  ShopUpdateDeliveredRefundRepo shopUpdateDeliveredRefundRepo =
      ShopUpdateDeliveredRefundRepo();

  ShopOrderViewRequestModel get shopOrderViewReqModel =>
      ShopOrderViewRequestModel(orderId: orderId.toString());

  //////////////
  ShopOwnerOrderStatusChangedRepo orderStatusChangedRepo =
      ShopOwnerOrderStatusChangedRepo();

  ShopUpdateRefundRepo shopUpdateRefundRepo = ShopUpdateRefundRepo();

  OrderStatusChangeRequestModel get orderStatusChangedRequestModel =>
      OrderStatusChangeRequestModel(
          orderId: orderId.toString(),
          orderStatus: orderStatus.toString(),
          orderCancelledReason: orderCancelledReason.toString(),
          orderCancelledReasonId: orderCancelledReasonId.toString(),
          deliveryCode: deliveryCode.toString());

  Future<void> initState(
    context,
    orId,
  ) async {
    orderId = "";
    orderStatus = "";
    orderCancelledReason = "";
    orderCancelledReasonId = "";
    deliveryCode = "";
    reasonController.clear();
    rejectReasonController.clear();
    acceptPayment = false;
    rejectPayment = false;
    isRefundByCash = false;
    isRefundByUpi = false;
    upiIdController.clear();
    refundPayableAmount.clear();
    await shopOwnerOrderView(context, orId, true);

    getCancelOrderList(context);
    notifyListeners();
  }

  void showLoader(value) {
    isLoading = value;
    print("loading........${isLoading}");
    notifyListeners();
  }

  Future<void> shopOwnerOrderView(context, orId, showLoading) async {
    if (showLoading) {
      showLoader(true);
    }
    selectedProductList.clear();
    orderId = orId.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    shopOrderViewRepo
        .shopOrderView(shopOrderViewReqModel, pref.getString("successToken"))
        .then((response) async {
      log(response.body);
      final result = ShopOrderViewResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if (result.status == 200) {
          shopOrderViewData = result.shopOrderViewData;
          orderDetails = shopOrderViewData?.orderDetails;
          couponDetails = shopOrderViewData?.couponDetails;
          deliveryAddressDetails = shopOrderViewData?.deliveryAddressDetails;
          orderProductDetails = shopOrderViewData?.orderProductDetails;
          subTotal = orderDetails?.subTotal ?? "";
          totalAmount = orderDetails?.totalAmount ?? "";
          deliveryCharges = orderDetails?.deliveryCharges ?? "";
          totalDiscount = orderDetails?.totalDiscount ?? "";
          totalRefundAmount = shopOrderViewData?.orderRefundAmount ?? "0";
          selectedProductList = List<bool>.filled(
              orderProductDetails?.length ?? 0, false,
              growable: true);
          int productListLength = orderProductDetails?.length ?? 0;
          for (int i = 0; i < productListLength; i++) {
            if (orderProductDetails?[i].status == "active") {
              selectedProductList.removeAt(i);
              selectedProductList.insert(i, true);
            } else {
              selectedProductList.removeAt(i);
              selectedProductList.insert(i, false);
            }
          }
          print("selectedProductList${selectedProductList}");
          if (orderDetails?.shopOwnerRefundStatus == "pending") {
            if (orderDetails?.customerCancelledStatus == "YES" ||
                orderDetails?.shopOwnerCancelledStatus == "YES") {
              acceptPayment = true;
            }
          }

          await getCancelOrderList(context);
          if (showLoading) {
            showLoader(false);
          } else {
            showLoader(true);
          }
          isDetailsAvailable = true;
          notifyListeners();
        } else {
          isDetailsAvailable = false;
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
          showLoader(false);
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

  OrderInvoiceRequestModel get orderInvoiceRequestModel =>
      OrderInvoiceRequestModel(orderId: orderId.toString());

  Future<void> orderInvoice(context) async {
    ///////
    // orderId = oId;
    // getDownloadPath();

    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    orderInvoicerepo
        .orderInvoice(orderInvoiceRequestModel, pref.getString("successToken"))
        .then((response) async {
      log(response.body);
      final result = OrderInvoiceResModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        orderinvoicedata = result.orderinvoiecdata;
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
          String fullPath =
              orderinvoicedata?.customerInvoiceList?.invoiceLink.toString() ??
                  "";
          List splitPath = fullPath.split("/");
          print(splitPath);
          String saveName = splitPath[splitPath.length - 1];
          print("savename${saveName}");
          String savePath = dir.path + "/$saveName";
          print(savePath);
          fileurl = Endpoint.baseUrl
                  .toString()
                  .substring(0, Endpoint.baseUrl.toString().length - 4)
                  .toString() +
              "${orderinvoicedata?.customerInvoiceList?.invoiceLink.toString()}";
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
            print(e.message);
            Utils.showPrimarySnackbar(context, "Invalid Url",
                type: SnackType.error);
            return;
          }
          _showNotification(saveName, savePath);
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

  Future<void> _showNotification(fileName, savePath) async {
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

  Future<void> shopOrderStatus(
      context, orId, oStatus, oCReason, oCReasonId, dCode) async {
    orderId = orId.toString();
    orderStatus = oStatus.toString();
    orderCancelledReason = oCReason.toString();
    orderCancelledReasonId = oCReasonId.toString();
    deliveryCode = dCode.toString();

    if (oStatus == "order_confirmed") {
      List checkDataList = [];
      for (int i = 0; i < selectedProductList.length; i++) {
        print(selectedProductList);
        if (selectedProductList[i] == true) {
          checkDataList.add(selectedProductList[i]);
        }
        print(checkDataList);
      }
      if (checkDataList.isEmpty) {
        Utils.showPrimarySnackbar(context, "No product selected",
            type: SnackType.error);
        return;
      }
    }

    if (oStatus == "order_cancelled") {
      if (!isOtherReasonSelected && orderCancelledReasonId == "") {
        cancelOrderErrorMsg = "Please Enter reason for cancellation";
        isCancelOrderErrorMsgVisible = true;
        notifyListeners();
        Timer(Duration(seconds: 3), () {
          isCancelOrderErrorMsgVisible = false;
          notifyListeners();
        });
        return;
      }
      if (orderCancelledReason == "") {
        cancelOrderErrorMsg = "Please Enter reason for cancellation";
        isCancelOrderErrorMsgVisible = true;
        notifyListeners();
        Timer(Duration(seconds: 3), () {
          isCancelOrderErrorMsgVisible = false;
          notifyListeners();
        });
        return;
      }
    }

    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    orderStatusChangedRepo
        .orderStatus(
            orderStatusChangedRequestModel, pref.getString("successToken"))
        .then((response) async {
      final result =
          OrderStatusChangeResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if (oStatus == "order_cancelled") {
          await shopOwnerOrderView(context, orId, true);
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => SMainScreenView(
          //           index: 1,
          //           screenName: SOrderStatusView(
          //             selectedIndex: 4,
          //             isFromOrderView: true,
          //           ))),
          //   (Route<dynamic> route) => false,
          // );
        }
        if (result.message != "Delivery code not matched. Please try again.") {
          print("dafaadadasd");
          await shopOwnerOrderView(context, orId, true);
          isDeliveryCodeError = false;
          if (oStatus == "order_delivered") {
            Navigator.pop(context);
          }
          if (oStatus == "order_cancelled") {
            Navigator.pop(context);
          }
        } else {
          showLoader(false);
          deliveryCodeError = result.message ?? "";
          isDeliveryCodeError = true;
          notifyListeners();
          Timer(Duration(seconds: 3), () {
            isDeliveryCodeError = false;
            notifyListeners();
          });
        }
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

  Future<void> getCancelOrderList(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    orderCancelReasonRepo.OrderCancelReason(pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result = CancelModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        cancelReasondata = result.cancelReasondata;
        int cancelOrderLength = cancelReasondata?.length ?? 0;
        isSelectedReason = List<bool>.filled(cancelOrderLength, false);
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

  // void onSelectReason(value) {
  //   if (!isSelectedReason) {
  //     isSelectedReason = true;

  //   } else {
  //     isSelectedReason = false;
  //   }
  //   notifyListeners();
  // }

  void onSelectReason(index, value, id) {
    if (isSelectedReason[index]) {
      isSelectedReason[index] = false;
      cancellationId = "";
      notifyListeners();
      return;
    }
    int cancelOrderLength = cancelReasondata?.length ?? 0;

    isSelectedReason =
        List<bool>.filled(cancelOrderLength, false, growable: true);
    isSelectedReason[index] = true;
    cancellationId = id.toString();
    isOtherReasonSelected = false;

    // isSelectedReason[index]=true;

    notifyListeners();
  }

  void onOtherSelected(value) {
    if (isOtherReasonSelected) {
      isOtherReasonSelected = false;
      notifyListeners();
      return;
    }
    int cancelOrderLength = cancelReasondata?.length ?? 0;
    isSelectedReason =
        List<bool>.filled(cancelOrderLength, false, growable: true);
    isOtherReasonSelected = true;
    notifyListeners();
  }

  void onCancelErrorMissageDismiss() {
    isCancelOrderErrorMsgVisible = false;
    notifyListeners();
  }

  Future<void> onDeliveryCode(code) async {
    deliveryCode = code;
    notifyListeners();
  }

  void onCodeDismiss() {
    isDeliveryCodeError = false;
    notifyListeners();
  }

  AddRemoveProductFromOrderReqModel get addRemoveProductFromOrderReqModel =>
      AddRemoveProductFromOrderReqModel(
        orderProductId: productId,
      );

  Future<void> selectProducts(context, index, id, value) async {
    LoadingOverlay.of(context).show();

    productId = id.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    addRemoveProductFromOrderRepo
        .addremoveProductFromOrder(
            addRemoveProductFromOrderReqModel, pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result =
          AddRemoveProductFromOrderResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if (selectedProductList[index]) {
          selectedProductList.removeAt(index);
          selectedProductList.insert(index, false);
        } else {
          selectedProductList.removeAt(index);
          selectedProductList.insert(index, true);
        }

        totalDiscount = result.data?.totalDiscount.toString() ?? "";
        totalAmount = result.data?.totalAmount.toString() ?? "";
        subTotal = result.data?.subTotalAmount.toString() ?? "";
        deliveryCharges = result.data?.deliveryCharges.toString() ?? "";

        totalRefundAmount = result.data?.totalRefundAmount.toString() ?? "";
        // couponDetails = result.data?.couponDetails ?? "";
//
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

  void onRefundAccept() {
    acceptPayment = true;
    rejectPayment = false;
    notifyListeners();
  }

  void onRefundReject() {
    acceptPayment = false;
    rejectPayment = true;
    notifyListeners();
  }

  void onRefundByCash(value) {
    if (!isRefundByCash) {
      isRefundByCash = true;
      isRefundByUpi = false;
    } else {
      isRefundByCash = false;
      isRefundByUpi = false;
    }
    notifyListeners();
  }

  void onRefundByUpi(value) {
    if (!isRefundByUpi) {
      isRefundByUpi = true;
      isRefundByCash = false;
    } else {
      isRefundByCash = false;
      isRefundByUpi = false;
    }
    notifyListeners();
  }

  ShopUpdateRefundReqModel get shopUpdateRefundReqModel =>
      ShopUpdateRefundReqModel(
        orderId: orderId,
        refundOrderStatus: acceptPayment ? "accept" : "reject",
        refundPaymentType: isRefundByCash ? "cash" : "upi",
        refundRejectReason: rejectReasonController.text,
        refunPayableAmount: refundPayableAmount.text,
        transactionId: upiIdController.text,
      );

  Future<void> shopRefundUpdate(context) async {
    if (acceptPayment) {
      if (refundPayableAmount.text == "") {
        Utils.showPrimarySnackbar(context, "Please Enter Refundable Amount",
            type: SnackType.error);
        return;
      }
      if (isRefundByUpi && upiIdController.text == "") {
        Utils.showPrimarySnackbar(context, "Please Enter Transaction Id",
            type: SnackType.error);
        return;
      }
      if (!isRefundByCash && !isRefundByUpi) {
        Utils.showPrimarySnackbar(context, "Please Select Payment Method",
            type: SnackType.error);
        return;
      }
    } else {
      if (rejectReasonController.text == "") {
        Utils.showPrimarySnackbar(context, "Please Enter Reject Reason",
            type: SnackType.error);
        return;
      }
    }

    LoadingOverlay.of(context).show();
    print("loading");
    SharedPreferences pref = await SharedPreferences.getInstance();
    shopUpdateRefundRepo
        .shopUpdateRefund(
            shopUpdateRefundReqModel, pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result =
          ShopUpdateRefundResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        LoadingOverlay.of(context).hide();
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
        refundPayableAmount.clear();
        upiIdController.clear();
        reasonController.clear();

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => SMainScreenView(
                  index: 2,
                  screenName: SPaymentRefundList(
                    isNavFromAccounts: false,
                  ))),
          (Route<dynamic> route) => false,
        );
        notifyListeners();
      } else {
        LoadingOverlay.of(context).hide();
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      LoadingOverlay.of(context).hide();
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
      (Object e) {
        LoadingOverlay.of(context).hide();
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e) {
        LoadingOverlay.of(context).hide();
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }

  ShopOwnerDeliveredRefundSubmitReqModel
      get shopOwnerDeliveredRefundSubmitReqModel =>
          ShopOwnerDeliveredRefundSubmitReqModel(
            orderId: orderId,
            shopDeliveredRefundStatus: "YES",
            shopDeliveredPaymentType: "upi",
            shopDeliveredPayableAmount: refundPayableAmount.text,
            shopDeliveredTransactionId: upiIdController.text,
          );

  Future<void> shopDeliveredRefundUpdate(context) async {
    print(orderId);
    print(refundPayableAmount.text);
    print(upiIdController.text);

    if (refundPayableAmount.text == "") {
      Utils.showPrimarySnackbar(context, "Please Enter Refundable Amount",
          type: SnackType.error);
      return;
    }
    if (!isRefundByCash && !isRefundByUpi) {
      Utils.showPrimarySnackbar(context, "Please Select Payment Method",
          type: SnackType.error);
      return;
    }

    LoadingOverlay.of(context).show();
    print("loading");
    SharedPreferences pref = await SharedPreferences.getInstance();
    shopUpdateDeliveredRefundRepo
        .shopUpdateRefund(shopOwnerDeliveredRefundSubmitReqModel,
            pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result = ShopOwnerDeliveredRefundSubmitResModel.fromJson(
          jsonDecode(response.body));
      if (response.statusCode == 200) {
        LoadingOverlay.of(context).hide();
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
        refundPayableAmount.clear();
        upiIdController.clear();
        reasonController.clear();
        shopOwnerOrderView(context, orderId, true);
        notifyListeners();
      } else {
        LoadingOverlay.of(context).hide();
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      LoadingOverlay.of(context).hide();
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
      (Object e) {
        LoadingOverlay.of(context).hide();
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e) {
        LoadingOverlay.of(context).hide();
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }

///////////////////////////////
}
