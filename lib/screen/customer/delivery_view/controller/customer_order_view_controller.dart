import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_supper_market/main.dart';
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/cart/view/cart_screen_view.dart';
import 'package:local_supper_market/screen/customer/delivery_view/model/customer_cancel_order_model.dart';
import 'package:local_supper_market/screen/customer/delivery_view/model/get_cancel_order_model.dart';
import 'package:local_supper_market/screen/customer/delivery_view/model/order_invoice_download_model.dart';
import 'package:local_supper_market/screen/customer/delivery_view/model/order_view_model.dart';
import 'package:local_supper_market/screen/customer/delivery_view/model/order_view_model.dart';
import 'package:local_supper_market/screen/customer/delivery_view/model/reorder_model.dart';
import 'package:local_supper_market/screen/customer/delivery_view/model/review_list_model.dart';
import 'package:local_supper_market/screen/customer/delivery_view/model/submit_review_model.dart';
import 'package:local_supper_market/screen/customer/delivery_view/model/update_refund_status_model.dart';
import 'package:local_supper_market/screen/customer/delivery_view/repository/customer_cancel_order_repo.dart';
import 'package:local_supper_market/screen/customer/delivery_view/repository/get_cancel_order_view_repo.dart';
import 'package:local_supper_market/screen/customer/delivery_view/repository/order_invoiec_repo.dart';
import 'package:local_supper_market/screen/customer/delivery_view/repository/order_view_repo.dart';
import 'package:local_supper_market/screen/customer/delivery_view/repository/reorder_repo.dart';
import 'package:local_supper_market/screen/customer/delivery_view/repository/review_list_repo.dart';
import 'package:local_supper_market/screen/customer/delivery_view/repository/submit_review_repo.dart';
import 'package:local_supper_market/screen/customer/delivery_view/repository/update_refund_status_repo.dart';
import 'package:local_supper_market/screen/customer/delivery_view/view/order_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/my_order/view/my_order_view.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/add_fav_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/remove_fav_shop_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/add_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/remove_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerOrderViewController extends ChangeNotifier {
  String orderId = "";
  String shopId = "";
  TextEditingController reviewController = TextEditingController();
  double? ratingValue;
  // int? ratingValueTwo;
  // int? ratingValueThree;
  // int? ratingValueFour;
  // int? ratingValueFive;
  String orderCancelledReason = "";
  String orderCancelledReasonId = "";
  String cancellationId = "";
  String cancelOrderErrorMsg = "";
  bool isOtherReasonSelected = false;
  bool favAllShop = true; /////shop add fvrt
  AddFavShopRepo addFavShopRepo = AddFavShopRepo();
  ReorderRepo reOrderRepo = ReorderRepo();
  OReviewListRepo oReviewListrepo = OReviewListRepo();
  OrderInvoiceRepo orderInvoicerepo = OrderInvoiceRepo();
  OrderViewData? orderData;
  OrderDetails? orderDetails;
  CouponDetails? couponDetails;
  ShopDetails? shopDetails;
  DeliveryAddressDetails? deliveryAddressDetails;
  List<OrderProductDetail>? orderProductDetails;
  bool isLoading = true;
  bool isCancelOrderErrorMsgVisible = false;
  List<bool> isSelectedReason = [];
  List<CustomerCancelReasonList>? cancelReasondata;
  TextEditingController reasonController = TextEditingController();
  List<ReviewList>? reviewList;
  OReviewlistData? oreviewlistdata;
  String? selectedRefundStatus;
  CustomerInvoiceList? customerInvoiceList;
  OrderInvoiceData? orderinvoicecdata;
  UpdateRefundStatusRepo updateRefundStatusRepo = UpdateRefundStatusRepo();
  String fileurl = "";
  Directory? directory;
  CustomerOrderViewRequestModel get customerOrderViewRequestModel =>
      CustomerOrderViewRequestModel(orderId: orderId.toString());
  //////////////
  OrderViewRepo orderViewRepo = OrderViewRepo();
  SubmitReviewRepo submitReviewRepo = SubmitReviewRepo();
  // ShopReviewListRepo shopReviewListRepo = ShopReviewListRepo();
  GetCustomerCancelOrderRepo getcustomerCancelOrderRepo =
      GetCustomerCancelOrderRepo();
  CustomerCancelOrderRepo customerCancelOrderRepo = CustomerCancelOrderRepo();

  Future<void> initState(
    context,
    orId,
  ) async {
    orderId = "";
    orderCancelledReason = "";
    orderCancelledReasonId = "";
    reasonController.clear();
    print("rvmjioureicvnwcy");
    print(orId);
    await customerOrderView(context, orId);
    getCancelOrderList(context);
    OReviewList(context);
    notifyListeners();
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> customerOrderView(context, orId) async {
    orderId = orId.toString();
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    orderViewRepo
        .showOrderView(
            customerOrderViewRequestModel, pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result =
          CustomerOrderViewResponseModel.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        orderData = result.orderData;
        orderDetails = orderData?.orderDetails;
        couponDetails = orderData?.couponDetails;
        shopDetails = orderData?.shopDetails;
        deliveryAddressDetails = orderData?.deliveryAddressDetails;
        orderProductDetails = orderData?.orderProductDetails;
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

  UpdateRefundStatusReqModel get updateRefundStatusReqModel =>
      UpdateRefundStatusReqModel(
        orderId: orderId,
        paymentStatus: selectedRefundStatus,
      );

  Future<void> updateRefundStatus(value, context) async {
    selectedRefundStatus = value;
    LoadingOverlay.of(context).show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    updateRefundStatusRepo
        .updateRefundStatus(
            updateRefundStatusReqModel, pref.getString("successToken"))
        .then((response) async {
      log(response.body);
      final result =
          UpdateRefundStatusResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        await customerOrderView(context, orderId);
        showLoader(false);
        LoadingOverlay.of(context).hide();
        if(value=="not_received"){
          Utils.showPrimarySnackbar(context,"Have send notification regarding this concern. Will connect with you shortly.",
              type: SnackType.success);
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

  void launchPhone(String mobNumber, context) async {
    var number = Uri.parse("tel:${mobNumber}");
    if (await canLaunchUrl(number)) {
      await launchUrl(number);
    } else {
      Utils.showPrimarySnackbar(context, "Unable to dial at the moment",
          type: SnackType.error);
    }
  }

  //////////////////////
  AddFavReqModel get addFavReqModel => AddFavReqModel(
        shopId: shopId.toString(),
      );
  Future<void> updateAllShopFavList(context, id) async {
    shopId = id.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    addFavShopRepo
        .updateAddFavShop(addFavReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = AddFavResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        favAllShop = true;
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

  RemoveFavReqModel get removeFavReqModel => RemoveFavReqModel(
        shopId: shopId.toString(),
      );
  RemoveFavShopRepo removeFavShopRepo = RemoveFavShopRepo();

  Future<void> removeAllShopFavList(context, id) async {
    shopId = id.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    removeFavShopRepo
        .updateRemoveFavShop(removeFavReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = RemoveFavResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        favAllShop = false;
        print("hello");
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

  Future<void> getCancelOrderList(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    getcustomerCancelOrderRepo
        .cOrderCancelReason(pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result =
          CustomerCancelOrderModel.fromJson(jsonDecode(response.body));
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

  void onSelectReason(index, value, id) {
    print("lllllllllllllllllllllllllll");
    print(id);
    print("lllllllllllllllllllllllllll");
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
    print("jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj");
    print(cancellationId);
    print("jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj");
    isOtherReasonSelected = false;

    // isSelectedReason[index] = true;

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

  CustomerCancelOrderRequestModel get customerOrderCancelReqModel =>
      CustomerCancelOrderRequestModel(
        orderCancelledReason: reasonController.text,
        orderId: orderId.toString(),
        orderCancelledReasonId: cancellationId,
      );

  Future<void> CustomerOrderCancel(
    context,
    oId,
    oCReason,
    oCReasonId,
  ) async {
    orderId = oId;
    orderCancelledReason = oCReason;

    if (reasonController.text == "") {
      cancelOrderErrorMsg = "Please Enter reason for cancellation";
      isCancelOrderErrorMsgVisible = true;
      notifyListeners();
      Timer(Duration(seconds: 3), () {
        isCancelOrderErrorMsgVisible = false;
        notifyListeners();
      });
      return;
    }
    if (cancellationId == "") {
      cancelOrderErrorMsg = "Please select Reason";
      isCancelOrderErrorMsgVisible = true;
      notifyListeners();
      Timer(Duration(seconds: 3), () {
        isCancelOrderErrorMsgVisible = false;
        notifyListeners();
      });
      return;
    }

    SharedPreferences pref = await SharedPreferences.getInstance();
    customerCancelOrderRepo
        .customerCancelOrder(
            customerOrderCancelReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = AddFavResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MainScreenView(index: 4, screenName: MyOrderView())),
          (Route<dynamic> route) => false,
        );

        print("hello");
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

  /////////////////////////////////Reorder/////////////////////////
  ///
  CustomerReorderRequestModel get customerReOrderReqModel =>
      CustomerReorderRequestModel(
        orderId: orderId.toString(),
      );
  Future<void> CustomerReorder(context, oId) async {
    LoadingOverlay.of(context).show();
    orderId = oId.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    reOrderRepo
        .reorder(customerReOrderReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result =
          CustomerReorderResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MainScreenView(index: 2, screenName: CartScreenView())),
          (Route<dynamic> route) => false,
        );

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

  /////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////
  SubmitReviewRequestModel get submitReviewRequestModel =>
      SubmitReviewRequestModel(
          shopId: shopDetails?.id.toString(),
          orderId: orderId.toString(),
          review: reviewController.text,
          rating: ratingValue.toString());
  Future<void> shopSubmitreview(context) async {
    if (reviewController.text == "") {
      Utils.showPrimarySnackbar(context, "Please  Enter Your Feedback",
          type: SnackType.error);
      notifyListeners();
      return;
    }
    SharedPreferences pref = await SharedPreferences.getInstance();
    submitReviewRepo
        .submitReview(submitReviewRequestModel, pref.getString("successToken"))
        .then((response) async {
      log("response.body${response.body}");
      final result =
          SubmitReviewResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        ratingValue = null;
        reviewController.clear();
        await OReviewList(context);

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

  void onRatingSelect(value) {
    ratingValue = value;
    notifyListeners();
  }

  ReviewListRequestModel get reviewListRequestModel => ReviewListRequestModel(
        orderId: orderId.toString(),
      );
  Future<void> OReviewList(context) async {
    showLoader(true);
    // LoadingOverlay.of(context).show();
    // orderId = oId.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    oReviewListrepo
        .oreviewList(reviewListRequestModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = ReviewListReponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        oreviewlistdata = result.oreviewlistdata;
        reviewList = oreviewlistdata?.reviewList;
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) =>
        //           MainScreenView(index: 2, screenName: CartScreenView())),
        //       (Route<dynamic> route) => false,
        // );

        print("hello");
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
        // LoadingOverlay.of(context).hide();
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

//////////////////////////////////Order Invoice/////////////////////
  OrderInvoiceRequestModel get orderInvoiceRequestModel =>
      OrderInvoiceRequestModel(orderId: orderId.toString());

  Future<void> orderInvoice(context) async {
    // orderId = oId;
    // getDownloadPath();

    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    orderInvoicerepo.orderInvoice(
        orderInvoiceRequestModel, pref.getString("successToken"))
        .then((response) async {
      log(response.body);
      final result = OrderInvoiceResModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        orderinvoicecdata = result.orderinvoiecdata;
        Map<Permission, PermissionStatus> statuses = await [
          Permission.storage,
          //add more permission to request here.
        ].request();
        var dir;
        if (Platform.isIOS) {
          dir = await getApplicationDocumentsDirectory();
        } else {
          dir = Directory('/storage/emulated/0/Download');
        }

        if (dir != null) {
          String fullPath =
              orderinvoicecdata?.customerInvoiceList?.invoiceLink.toString() ??
                  "";
          List splitPath = fullPath.split("/");
          print(splitPath);
          String saveName = splitPath[splitPath.length - 1];
          print("savename${saveName}");
          String savePath = dir.path + "/$saveName";
          print(savePath);
          fileurl=Endpoint.baseUrl.toString().substring(0,Endpoint.baseUrl.toString().length-4).toString()+"${orderinvoicecdata?.customerInvoiceList?.invoiceLink.toString()}";
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
            Utils.showPrimarySnackbar(context,"Invalid Url", type: SnackType.error);
            return;
          }
          _showNotification(saveName);
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

  Future<void> _showNotification(fileName) async {
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
        payload: '$fileName');
  }
}
