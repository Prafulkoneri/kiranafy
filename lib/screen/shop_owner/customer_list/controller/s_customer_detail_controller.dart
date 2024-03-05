import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/customer_list/model/customer_detail_model.dart';
import 'package:local_supper_market/screen/shop_owner/customer_list/repository/customer_detail_repo.dart';
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
    var number = Uri.parse("tel:$mobNumber");
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
      log(response.body);
      final result = CustomerDetailResModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        shopCustomerDetailData = result.shopCustomerDetailData;
        customerDetails = shopCustomerDetailData?.customerDetails;
        customerOrderDetails = shopCustomerDetailData?.customerOrderDetails;
        // customerDetail = result.data;
        showLoader(false);
        notifyListeners();
      }
      else if(response.statusCode == 401){
        Utils().logoutUser(context);
      }
      else {
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
