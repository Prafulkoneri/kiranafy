import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:local_supper_market/screen/customer/account/model/profile_detail_cmodel.dart';
import 'package:local_supper_market/screen/customer/account/repository/c_profile_repo.dart';

import 'package:local_supper_market/screen/customer/delivery_address/view/my_delivery_address.dart';
import 'package:local_supper_market/screen/customer/favourites/view/favourites_view.dart';
import 'package:local_supper_market/screen/customer/my_order/view/my_order_view.dart';
import 'package:local_supper_market/screen/customer/profile/view/update_profile_view.dart';
import 'package:local_supper_market/screen/on_boarding/view/on_boarding_screen_view.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../notifications/view/notification_view.dart';

class ProfileController extends ChangeNotifier {
  CustomerData? customerData;

  Future<void> initState(
    context,
  ) async {
    await getCustomerProfileDetails(context);
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
void onLogout(context)async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  pref.clear();
  Navigator.push(context,MaterialPageRoute(builder: (context)=>OnBoardingScreenView()));
}

  void onFavouritesClicked(context)async{
    Navigator.push(context,MaterialPageRoute(builder: (context)=>CFavouritesView()));
  }


  void myDeliveryAddressPressed(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyDeliveryAddress()));
  }

////Detail Profile
  Future<void> getCustomerProfileDetails(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    customerProfileRepo
        .getCustomerProfile(pref.getString("successToken"))
        .then((response) {
      final result = CustomerProfileDetailsRes.fromJson(
        jsonDecode(response.body),
      );
      if (response.statusCode == 200) {
        customerData=result.data;
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
