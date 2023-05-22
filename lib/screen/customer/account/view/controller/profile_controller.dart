import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:local_supper_market/screen/customer/account/model/profile_detail_cmodel.dart';
import 'package:local_supper_market/screen/customer/account/repository/c_profile_repo.dart';

import 'package:local_supper_market/screen/customer/delivery_address/view/my_delivery_address.dart';
import 'package:local_supper_market/screen/customer/my_order/view/my_order_view.dart';
import 'package:local_supper_market/screen/customer/profile/view/update_profile_view.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../notifications/view/notification_view.dart';

class ProfileController extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobilrController = TextEditingController();
  TextEditingController alernetMobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  Future<void> initState(
    context,
  ) async {
    await getCustoerProfileDetails(context);
  }

  CustomerProfileRepo customerProfileRepo = CustomerProfileRepo(); ////;
  void onEditProfilePressed(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UpdateProfileView()));
  }

  void myOrdersPressed(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyOrderView()));
  }

  void myNotificationsPressed(context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => NotificationsScreenView()));
  }

  void favouritesPressed(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyOrderView()));
  }

  void myDeliveryAddressPressed(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyDeliveryAddress()));
  }

////Detail Profile
  Future<void> getCustoerProfileDetails(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    customerProfileRepo
        .getCustomerProfileReo(pref.getString("successToken"))
        .then((response) {
      final result = CustomerProfileDetailsRes.fromJson(
        jsonDecode(response.body),
      );
      if (response.statusCode == 200) {
        final data = result.data;
        print(data);
        log("${response.body}");
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
  /////End Detail Profile
}
