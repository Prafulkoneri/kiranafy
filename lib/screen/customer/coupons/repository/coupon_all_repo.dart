import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class CAllCouponList {
  Future<http.Response> couponList(token) async {
    print(Uri.parse(Endpoint.customerAllCouponList));
    try {
      return await http.get(Uri.parse(Endpoint.customerAllCouponList), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
