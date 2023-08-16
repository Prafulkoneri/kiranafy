import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/delivery_view/view/order_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/return/model/check_product_model.dart';
import 'package:local_supper_market/screen/customer/return/model/return_model.dart';
import 'package:local_supper_market/screen/customer/return/model/sumbit_return_order_model.dart';
import 'package:local_supper_market/screen/customer/return/repository/check_product_return_repo.dart';
import 'package:local_supper_market/screen/customer/return/repository/return_repo.dart';
import 'package:local_supper_market/screen/customer/return/repository/submit_return_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReturnOrderController extends ChangeNotifier {
  String? orderId = "";
  String? description = "";
  String? productAmount = "";

  String? checkStatus = "";
  String? pId = "";
  ReturnProductListData? returnproductlistdata;
  OrderDetails? orderDetails;
  ShopDetails? shopDetails;
  List<RefundReasonDetail>? refundReasonDetails;
  List<OrderProductDetail>? orderProductDetails;
  List<bool> isSelectedReason = [];
  String cancellationId = "";
  String cancelOrderErrorMsg = "";
  bool isOtherReasonSelected = false;
  bool isCancelOrderErrorMsgVisible = false;
  TextEditingController descriptionController = TextEditingController();
  CheckProductListData? checkproductlistdata;
  List selectedProductIdList = [];
  List<bool> isReturnProductSelected = [];
  String productCount = "";
  int refundTotal = 0;
  String productId = "";
  bool isLoading = true;
  SubmitReturnRepo submitReturnRepo = SubmitReturnRepo();

  Future<void> initState(context, oId) async {
    productId="";
    refundTotal=0;
    selectedProductIdList.clear();
    isReturnProductSelected.clear();
    descriptionController.clear();

    await returnOrder(context, oId);
    notifyListeners();
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  OrderReturnRepo orderreturnrepo = OrderReturnRepo();

  COrderReturnListRequestModel get corderReturnListRequestModel =>
      COrderReturnListRequestModel(
        orderId: orderId,
      );
  Future<void> returnOrder(context, oId) async {
    showLoader(true);
    orderId = oId.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    orderreturnrepo
        .orderReturn(
            corderReturnListRequestModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result =
          COrderReturnListResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        returnproductlistdata = result.returnproductlistdata;
        orderDetails = returnproductlistdata?.orderDetails;
        refundReasonDetails = returnproductlistdata?.refundReasonDetails;
        orderProductDetails = returnproductlistdata?.orderProductDetails;
        isReturnProductSelected = List<bool>.filled(
            orderProductDetails?.length ?? 0, false,
            growable: true);
        // int length = orderProductDetails?.length??0;
        // for(int i = 0  ; i < length;i++){
        //   selectedProductIdList.add(orderProductDetails?[i].id);
        // }
        // selectedProductIdList
        shopDetails = returnproductlistdata?.shopDetails;
        int cancelOrderLength = refundReasonDetails?.length ?? 0;
        isSelectedReason = List<bool>.filled(cancelOrderLength, false);
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

  //////////////////
  void onOtherSelected(value) {
    if (isOtherReasonSelected) {
      isOtherReasonSelected = false;
      notifyListeners();
      return;
    }
    int cancelOrderLength = refundReasonDetails?.length ?? 0;
    isSelectedReason =
        List<bool>.filled(cancelOrderLength, false, growable: true);
    isOtherReasonSelected = true;
    notifyListeners();
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
    int cancelOrderLength = refundReasonDetails?.length ?? 0;

    isSelectedReason =
        List<bool>.filled(cancelOrderLength, false, growable: true);
    isSelectedReason[index] = true;
    cancellationId = id.toString();
    print("jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj");
    print(cancellationId);
    print("jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj");
    isOtherReasonSelected = false;

    notifyListeners();
  }

  void onCancelErrorMissageDismiss() {
    isCancelOrderErrorMsgVisible = false;
    notifyListeners();
  }

  Future<void> onSelectingProduct(
      index, value, productId, productAmount,productCount) async {
    print(value);
    isReturnProductSelected[index] = !isReturnProductSelected[index];
    if (isReturnProductSelected[index]) {
      selectedProductIdList.add(productId);
      refundTotal =
          int.parse(refundTotal.toString()) + (int.parse(productAmount)*int.parse(productCount.toString()));
    } else {
      selectedProductIdList.removeWhere((element) => element==productId);
      refundTotal = int.parse(refundTotal.toString())-(int.parse(productAmount)*int.parse(productCount.toString()));
    }

    print(selectedProductIdList);
    notifyListeners();
  }

  SubmitReturnOrderReqModel get submitReturnOrderReqModel =>
      SubmitReturnOrderReqModel(
          productId: productId.toString(),
          customRefundReason: descriptionController.text,
          orderId: orderId,
          reasonId: cancellationId,
          customerRefundAmount: refundTotal.toString(),
          totalProducts: selectedProductIdList.length.toString());

  Future<void> submitRefundProduct(context) async {
    if (selectedProductIdList.isEmpty) {
      Utils.showPrimarySnackbar(context, "Select atleast one product",
          type: SnackType.error);
      return;
    }
    if (cancellationId == "") {
      Utils.showPrimarySnackbar(context, "Select any reason",
          type: SnackType.error);
      return;
    }
    if (descriptionController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter reason for return",
          type: SnackType.error);
      return;
    }
    LoadingOverlay.of(context).show();
    productId="";
    for (int i = 0; i < selectedProductIdList.length; i++) {
      productId += selectedProductIdList[i] + ",";
    }
    productId = productId.substring(0, productId.length - 1);
    print(productId);

    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    submitReturnRepo
        .submitReturn(submitReturnOrderReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result =
          SubmitReturnOrderResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderDeliveryView(
                      orderId: orderId,
                    )));
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
        LoadingOverlay.of(context).hide();
        notifyListeners();
      } else {
        LoadingOverlay.of(context).hide();
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
