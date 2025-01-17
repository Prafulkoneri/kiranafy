import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:local_supper_market/screen/customer/delivery_address/model/delete_address_model.dart';
import 'package:local_supper_market/screen/customer/delivery_address/model/delivery_address_list_model.dart';
import 'package:local_supper_market/screen/customer/delivery_address/model/mark_default_address_model.dart';
import 'package:local_supper_market/screen/customer/delivery_address/repository/delete_address_repo.dart';
import 'package:local_supper_market/screen/customer/delivery_address/repository/delivery_address_list_repo.dart';
import 'package:local_supper_market/screen/customer/delivery_address/repository/mark_default_address_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryAddressController extends ChangeNotifier {
  DeliveryAddressRepo DeliveryAddressListRepo = DeliveryAddressRepo();
  DefaultAddressRepo DefaultAddressMarkRepo = DefaultAddressRepo();
  DeleteAddressRepo deleteAddressRepo = DeleteAddressRepo();
  String deliveryAddressId = "";
  DefaultAddressRequestModel get markDefaultAddressRequestModel =>
      DefaultAddressRequestModel(
          deliveryAddressId: deliveryAddressId.toString());
  DeleteDeliveryAddressRequestModel get deleteAddressReqModel =>
      DeleteDeliveryAddressRequestModel(
          deliveryAddressId: deliveryAddressId.toString());
  List<DeliveryAddressList>? deliveryAddressList;

  List<bool> defaultSelectedAddress = [];

  bool isLoading = true;
  bool defaultAddress = true;
  Future<void> initState(context, isRefresh) async {
    if (isRefresh) {
      await getDeliveryAddressList(context);
    }
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  //////////Start Get Address List////
  Future<void> getDeliveryAddressList(
    context,
  ) async {
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    DeliveryAddressListRepo.getDeliveryAddress(pref.getString("successToken"))
        .then((response) {
      print(response.statusCode);
      log(response.body);
      final result =
          DeliveryAddressListModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        deliveryAddressList = result.data;
        defaultSelectedAddress = List<bool>.filled(
            deliveryAddressList?.length ?? 0, false,
            growable: true);
        int length = deliveryAddressList?.length ?? 0;
        for (int i = 0; i < length; i++) {
          if (deliveryAddressList?[i].deliveryAddressIsDefault == "yes") {
            defaultSelectedAddress.insert(i, true);
          } else {}
        }
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
  ////////////END////////////////

  ////Mark Default Address///////
  Future<void> markDefaultAddress(context, addressId, index) async {
    deliveryAddressId = addressId.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    DefaultAddressMarkRepo.markDefaultAddress(
            markDefaultAddressRequestModel, pref.getString("successToken"))
        .then((response) {
      print(response.statusCode);
      log(response.body);
      final result = DefaultAddressResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        defaultSelectedAddress = List<bool>.filled(
            deliveryAddressList?.length ?? 0, false,
            growable: true);
        defaultSelectedAddress.insert(index, true);

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

  /////////////Delete Address////////////
  Future<void> deleteAddress(context, index, addressId) async {
    deliveryAddressId = addressId.toString();

    SharedPreferences pref = await SharedPreferences.getInstance();

    deleteAddressRepo
        .deleteAddress(deleteAddressReqModel, pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result = DeleteDeliveryAddressResponseModel.fromJson(
          jsonDecode(response.body));
      if (response.statusCode == 200) {
        if (result.status == 200) {
          deliveryAddressList?.removeAt(index);
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.success);
        } else {
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
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
}
