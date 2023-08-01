import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'dart:developer';

import 'package:local_supper_market/screen/shop_owner/s_coupons/model/add_coupons_model.dart';

class AddCouponsRepo {
  Future<http.Response> addNewCoupons(
      AddCouponsRequestModel reqModel, token) async {
    print(reqModel.toJson());

    print(Uri.parse(Endpoint.addNewCoupons));
    log("${reqModel.toJson()}");
    try {
      return await http.post(Uri.parse(Endpoint.addNewCoupons),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
