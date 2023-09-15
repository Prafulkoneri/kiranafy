import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'dart:developer';
import 'package:local_supper_market/screen/shop_owner/s_coupons/model/delete_coupons_model.dart';

class DeleteCouponsRepo {
  Future<http.Response> deleteCoupons(
      DeleteCouponsReqModel reqModel, token) async {
    print(reqModel.toJson());

    print(Uri.parse(Endpoint.couponsDelete));
    log("${reqModel.toJson()}");
    try {
      return await http.post(Uri.parse(Endpoint.couponsDelete),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
