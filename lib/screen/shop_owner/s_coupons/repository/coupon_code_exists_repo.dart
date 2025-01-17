import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'dart:developer';

import 'package:local_supper_market/screen/shop_owner/s_coupons/model/coupon_code_exists_model.dart';

class CouponCodeExistsRepo {
  Future<http.Response> checkCouponCodeExists(
      CouponCodeExistsRequestModel reqModel, token) async {
    print(reqModel.toJson());

    print(Uri.parse(Endpoint.couponCodeExists));
    log("${reqModel.toJson()}");
    try {
      return await http.post(Uri.parse(Endpoint.couponCodeExists),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
