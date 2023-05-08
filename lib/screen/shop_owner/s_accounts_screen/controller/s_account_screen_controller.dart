

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/view/s_edit_profile_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/view/s_shop_configuration_view.dart';

class SAccountScreenController extends ChangeNotifier{
  void onEditBtnClicked(context){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>SEditProfileView()));
  }

  void onShopConfigurationClicked(context){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>SShopConfigurationView()));
  }

}