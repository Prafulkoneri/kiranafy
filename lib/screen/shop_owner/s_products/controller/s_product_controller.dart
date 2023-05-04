import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_add_product_view.dart';

class SAddProductsController extends ChangeNotifier {
  void onAddProduct(context) {
    print("hello");
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddProductView()));
  }
}
