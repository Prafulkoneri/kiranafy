import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

import 'dart:developer';

import 'package:local_supper_market/screen/shop_owner/s_coupons/model/coupons_product_and_category_model.dart';

class CouponsForProductAndCustomerRepo {
  Future<http.Response> couponsForProductAndCoustomer(
      CouponsForProductAndCategoryRequestModel reqModel, token) async {
    print(reqModel.toJson());

    print(Uri.parse(Endpoint.shopOwnerCouponsForProductlist));
    log("${reqModel.toJson()}");
    try {
      return await http.post(Uri.parse(Endpoint.shopOwnerCouponsForProductlist),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
