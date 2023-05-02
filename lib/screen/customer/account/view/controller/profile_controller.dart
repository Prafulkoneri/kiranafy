import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/delivery_address/view/my_delivery_address.dart';
import 'package:local_supper_market/screen/customer/my_order/view/my_order_view.dart';
import 'package:local_supper_market/screen/customer/profile/view/update_profile_view.dart';

class ProfileController extends ChangeNotifier {
  void onEditProfilePressed(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UpdateProfileView()));
  }

  void myOrdersPressed(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyOrderView()));
  }

  void myNotificationsPressed(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyOrderView()));
  }

  void favouritesPressed(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyOrderView()));
  }

  void myDeliveryAddressPressed(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyDeliveryAddress()));
  }
}
