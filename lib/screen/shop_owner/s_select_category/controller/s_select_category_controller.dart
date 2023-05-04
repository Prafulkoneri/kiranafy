import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_category_list/view/s_category_list_view.dart';

class SSelectCategoryController extends ChangeNotifier{
  void onAppBarActionPressed(context){
    print("hello");
    Navigator.push(context,MaterialPageRoute(builder: (context)=>SSCategoryListView()));
  }
}