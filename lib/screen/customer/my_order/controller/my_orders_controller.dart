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
  MyOrdersData? myOrdersData;
  List<OrderList>? orderList;
  List<OrderedShopsList>? orderedShopsList;
  bool isLoading=true;
  bool isStackLoaderVisible=false;

  void showLoader(value){
    isLoading=value;
    notifyListeners();
  }

  void showStackLoader(value){
    isStackLoaderVisible=value;
    notifyListeners();
  }

  Future<void> initState(context, id, orStatus) async {
    await getMyOrdersList(context, id, orStatus);
  }

  MyOrdersRequestModel get myOrderRequestModel => MyOrdersRequestModel(
      shopId: shopId.toString(), orderStatus: orderStatus.toString());


  Future<void> getMyOrdersList(context, id, orStatus) async {
    isLoading=false;
   isStackLoaderVisible=false;
    showLoader(true);
    shopId = id==null?"":id.toString();
    orderStatus =orStatus==null?"":orStatus.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    myOrderRepo
        .myOrders(myOrderRequestModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = MyOrdersResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        myOrdersData = result.myOrdersData;
        orderList = myOrdersData?.orderList;
        orderedShopsList = myOrdersData?.orderedShopsList;
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

  void onShopSelected(value){
    shopId=value;
    notifyListeners();
  }

  void onStatusSelected(value){
    orderStatus=value;
    notifyListeners();
  }

  Future<void> applyFilter(context)async{
    showStackLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    myOrderRepo
        .myOrders(myOrderRequestModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = MyOrdersResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        myOrdersData = result.myOrdersData;
        orderList = myOrdersData?.orderList;
        orderedShopsList = myOrdersData?.orderedShopsList;
        showStackLoader(false);
        Navigator.pop(context);
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
  Future<void> clearFilter(context)async{
    shopId="";
    orderStatus="";
    showStackLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    myOrderRepo
        .myOrders(myOrderRequestModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = MyOrdersResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        myOrdersData = result.myOrdersData;
        orderList = myOrdersData?.orderList;
        orderedShopsList = myOrdersData?.orderedShopsList;
        showStackLoader(false);
        Navigator.pop(context);
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
