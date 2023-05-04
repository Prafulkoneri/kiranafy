import 'package:flutter/cupertino.dart';

class SShopConfigurationController extends ChangeNotifier{
  bool isCustomerPickupSelected=false;
  bool isDeliveryCustomerSelected=false;
  void onCustomerPickupSelected(){
    isCustomerPickupSelected=!isCustomerPickupSelected;
    notifyListeners();
  }

  void onDeliveryCustomerSelected(){
    isDeliveryCustomerSelected=!isDeliveryCustomerSelected;
    notifyListeners();
  }

}