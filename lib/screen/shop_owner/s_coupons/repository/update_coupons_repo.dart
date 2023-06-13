import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'dart:developer';

import 'package:local_supper_market/screen/shop_owner/s_coupons/model/coupons_update_model.dart';

class UpdateCouponsRepo {
  Future<http.Response> updateCoupons(
      UpdateCouponReqModel reqModel, token) async {
    print(reqModel.toJson());

    print(Uri.parse(Endpoint.CouponsUpdate));
    log("${reqModel.toJson()}");
    try {
      return await http.post(Uri.parse(Endpoint.CouponsUpdate),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
