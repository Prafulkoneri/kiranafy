import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_status/model/get_order_list_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_status/repository/shop_order_list_epo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SOrderStatusController extends ChangeNotifier {
  ShopGetOrderListRepo shopGetOrderListRepo = ShopGetOrderListRepo();
  bool isLoading = true;
  ShopOrderListData? shopOrderList;
  List<ShopOrderList>? pendingOrdersList;
  List<ShopOrderList>? confirmedOrdersList;
  List<ShopOrderList>? inprocessOrdersList;
  List<ShopOrderList>? deliveredOrdersList;
  List<ShopOrderList>? cancelledOrdersList;
  int selectedIndex = 0;

  void onTabClicked(index) {
    selectedIndex = index;
    notifyListeners();
  }

  Future<void> initState(context, index) async {
    await getShopOrderList(context,index);
    notifyListeners();
  }

  showLoader(value){
    isLoading=value;
    notifyListeners();
  }

  Future<void> getShopOrderList(context,index) async {
    selectedIndex=index;
    showLoader(true);
    print("loading");
    SharedPreferences pref = await SharedPreferences.getInstance();
    shopGetOrderListRepo.SGetOrderListModel(pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result = SGetOrderListModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        shopOrderList = result.shopOrderList;
        pendingOrdersList = shopOrderList?.pendingOrdersList??[];
        confirmedOrdersList = shopOrderList?.confirmedOrdersList??[];
        inprocessOrdersList = shopOrderList?.inprocessOrdersList??[];
        deliveredOrdersList = shopOrderList?.deliveredOrdersList??[];
        cancelledOrdersList = shopOrderList?.cancelledOrdersList??[];
        selectedIndex=index;
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
}
