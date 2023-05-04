import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_category_list/view/s_category_list_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_products_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/view/s_select_category_view.dart';

class SDashBoardController extends ChangeNotifier {
  void onCategorySelect(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SSCategoryListView()));
  }
}
