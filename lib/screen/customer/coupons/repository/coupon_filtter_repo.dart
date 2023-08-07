import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class CouponFiltterRepo {
  Future<http.Response> couponFiltter(token) async {
    print(Uri.parse(Endpoint.couponFiltter));
    try {
      return await http.get(Uri.parse(Endpoint.couponFiltter), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
