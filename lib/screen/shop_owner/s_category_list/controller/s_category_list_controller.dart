import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_products_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/view/s_select_category_view.dart';

import '../../s_products/view/shop_custome_products_view.dart';

class SCategoryListController extends ChangeNotifier {
  void onAddBtnClicked(context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SSelectCategoryView()));
  }

  void onProductSelect(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ShopProductView()));
  }

  void onCustomProductSelect(context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ShopCustomProductView()));
  }
}
