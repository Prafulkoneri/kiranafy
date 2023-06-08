import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:local_supper_market/screen/customer/category/model/filtter_model.dart';
import 'package:local_supper_market/screen/customer/category/model/product_as_per_category_model.dart';
import 'package:local_supper_market/screen/customer/category/model/seach_product_as_per_category_model.dart';
import 'package:local_supper_market/screen/customer/category/repository/product_as_per_category_repo.dart';
import 'package:local_supper_market/screen/customer/category/repository/product_as_per_filter_repo.dart';
import 'package:local_supper_market/screen/customer/category/repository/search_product_as_per_category_repo.dart';
import 'package:local_supper_market/screen/customer/delivery_address/model/delivery_address_list_model.dart';
import 'package:local_supper_market/screen/customer/delivery_address/model/delivery_address_list_model.dart';
import 'package:local_supper_market/screen/customer/delivery_address/model/delivery_address_list_model.dart';
import 'package:local_supper_market/screen/customer/delivery_address/repository/delivery_address_list_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryAddressController extends ChangeNotifier {
  DeliveryAddressRepo DeliveryAddressListRepo = DeliveryAddressRepo();
  List<DeliveryAddressList>? deliveryAddressList;
  bool isLoading = true;
  bool defaultAddress = true;
  Future<void> initState(context) async {
    await getDeliveryAddressList(context);
  }

  Future<void> getDeliveryAddressList(
    context,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    DeliveryAddressListRepo.getDeliveryAddress(pref.getString("successToken"))
        .then((response) {
      print(response.statusCode);
      log(response.body);
      final result =
          DeliveryAddressListModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        deliveryAddressList = result.data;

        isLoading = false;
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
