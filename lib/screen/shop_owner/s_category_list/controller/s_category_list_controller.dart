

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/view/s_select_category_view.dart';

class SCategoryListController extends ChangeNotifier{
  void onAddBtnClicked(context){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>SSelectCategoryView()));
  }
}