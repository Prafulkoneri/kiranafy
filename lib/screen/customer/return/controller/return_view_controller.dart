

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/return/model/check_product_model.dart';
import 'package:local_supper_market/screen/customer/return/model/return_model.dart';
import 'package:local_supper_market/screen/customer/return/repository/check_product_return_repo.dart';
import 'package:local_supper_market/screen/customer/return/repository/return_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ReturnOrderController extends ChangeNotifier {
  String? orderId = "";
  String? description = "";
  String? productAmount = "";
  String productTotalAmount = "0";
  String? checkStatus = "";
  String? pId="";
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
  List selectedProductIdList=[];
  List<bool> isReturnProductSelected = [];

  int refundTotal=0;
  Future<void> initState(context,oId) async {
    selectedProductIdList.clear();
    isReturnProductSelected.clear();
  await  returnOrder(context,oId);
    notifyListeners();
  }
  OrderReturnRepo orderreturnrepo = OrderReturnRepo();

  COrderReturnListRequestModel get corderReturnListRequestModel =>
      COrderReturnListRequestModel(
          orderId: orderId,);
  Future<void> returnOrder(context,oId) async {
    orderId = oId.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    orderreturnrepo.orderReturn(
        corderReturnListRequestModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result =
      COrderReturnListResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        returnproductlistdata=result.returnproductlistdata;
        orderDetails=returnproductlistdata?.orderDetails;
        refundReasonDetails=returnproductlistdata?.refundReasonDetails;
        orderProductDetails=returnproductlistdata?.orderProductDetails;
        isReturnProductSelected=List<bool>.filled(orderProductDetails?.length??0, false,growable: true);
        // int length = orderProductDetails?.length??0;
        // for(int i = 0  ; i < length;i++){
        //   selectedProductIdList.add(orderProductDetails?[i].id);
        // }
        // selectedProductIdList
        shopDetails=returnproductlistdata?.shopDetails;
        int cancelOrderLength = refundReasonDetails?.length ?? 0;
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

    // isSelectedReason[index] = true;

    notifyListeners();
  }

  void onCancelErrorMissageDismiss() {
    isCancelOrderErrorMsgVisible = false;
    notifyListeners();
  }



  ///////////////////////////////////////////////////
  CheckProductReturnRepo checkproductreturnrepo = CheckProductReturnRepo();
  CheckProductRequestModel get checkProductrequestModel =>
      CheckProductRequestModel(productAmount: productAmount,productTotalAmount: refundTotal.toString(),
        checkStatus: checkStatus,);
  Future<void> checkProductReturn(context,index,pAmount,pTotalAmount,cStatus,pId,) async {
    productAmount = pAmount;
    refundTotal = pTotalAmount;
    checkStatus = cStatus;
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    checkproductreturnrepo.checkProductReturn(
        checkProductrequestModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result =
      CheckProductResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        checkproductlistdata =result.checkproductlistdata;
        refundTotal=checkproductlistdata?.refundTotal??0;
        if(checkStatus=="checked") {
          isReturnProductSelected[index]=true;
          selectedProductIdList.insert(index,pId);
        }
        else{
          isReturnProductSelected[index]=false;
          selectedProductIdList
              .removeAt(index);
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


  // void onSelectedProductReturnList(index, id) {
  //   selectedReturnProductList[index] = !selectedReturnProductList[index];
  //   if (selectedReturnProductList[index]) {
  //     pId.removeWhere((item) => item == id);
  //     pId?.insert(0, id);
  //   } else {
  //     selectedAddOnServicesId.removeWhere((item) => item == id);
  //   }
  //   print(selectedAddOnServicesId);
  //   notifyListeners();
  // }
}
