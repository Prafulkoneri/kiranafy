import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/account/model/profile_detail_cmodel.dart';
import 'package:local_supper_market/screen/on_boarding/view/on_boarding_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/customer_list/model/customer_detail_model.dart';
import 'package:local_supper_market/screen/shop_owner/customer_list/model/customer_list_model.dart';
import 'package:local_supper_market/screen/shop_owner/customer_list/repository/customer_detail_repo.dart';
import 'package:local_supper_market/screen/shop_owner/customer_list/repository/customer_list_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/model/shop_edit_profile_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/repository/shop_edit_profile_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/view/s_edit_profile_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/view/s_shop_configuration_view.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SCustomerDetailController extends ChangeNotifier {
  bool isLoading = true;
  String customerId = "";
  // ShopCustomerDetail? customerDetail;
  ShopCustomerDetail? shopCustomerDetailData; //
  CustomerDetails? customerDetails; //
  List<CustomerOrderDetail>? customerOrderDetails; //

  ShopCustomerDetailRepo shopCustomerDetailRepo = ShopCustomerDetailRepo();

  Future<void> initState(context, cID) async {
    await getCustomerDetailsView(context, cID);
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  ShopCustomerDetailReqModel get shopCustomerDetailReqModel =>
      ShopCustomerDetailReqModel(
        customerId: customerId,
      );

  void launchPhone(String mobNumber, context) async {
    var number = Uri.parse("tel:${mobNumber}");
    if (await canLaunchUrl(number)) {
      await launchUrl(number);
    } else {
      Utils.showPrimarySnackbar(context, "Unable to dial at the moment",
          type: SnackType.error);
    }
  }

  Future<void> getCustomerDetailsView(context, cID) async {
    customerId = cID;
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    shopCustomerDetailRepo
        .getCustomerDetails(
            shopCustomerDetailReqModel, pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result = CustomerDetailResModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        shopCustomerDetailData = result.shopCustomerDetailData;
        customerDetails = shopCustomerDetailData?.customerDetails;
        customerOrderDetails = shopCustomerDetailData?.customerOrderDetails;
        // customerDetail = result.data;
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
