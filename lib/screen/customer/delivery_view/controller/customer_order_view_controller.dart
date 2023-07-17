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
import 'package:local_supper_market/screen/customer/delivery_view/repository/customer_cancel_order_repo.dart';
import 'package:local_supper_market/screen/customer/delivery_view/repository/get_cancel_order_view_repo.dart';
import 'package:local_supper_market/screen/customer/delivery_view/repository/order_view_repo.dart';
import 'package:local_supper_market/screen/customer/delivery_view/repository/reorder_repo.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerOrderViewController extends ChangeNotifier {
  String orderId = "";
  String shopId = "";
  String orderCancelledReason = "";
  String orderCancelledReasonId = "";
  String cancellationId = "";
  String cancelOrderErrorMsg = "";
  bool isOtherReasonSelected = false;
  bool favAllShop = true; /////shop add fvrt
  AddFavShopRepo addFavShopRepo = AddFavShopRepo();
  ReorderRepo reOrderRepo = ReorderRepo();
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
  CustomerOrderViewRequestModel get customerOrderViewRequestModel =>
      CustomerOrderViewRequestModel(orderId: orderId.toString());
  //////////////
  OrderViewRepo orderViewRepo = OrderViewRepo();
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
    await shopOwnerOrderView(context, orId);
    getCancelOrderList(context);
    notifyListeners();
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> shopOwnerOrderView(context, orId) async {
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
}
