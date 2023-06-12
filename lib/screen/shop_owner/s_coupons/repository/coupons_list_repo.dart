import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class CouponsListRepo {
  Future<http.Response> getAllCouponsList(token) async {
    print(Uri.parse(Endpoint.allCouponsList));
    try {
      return await http.get(Uri.parse(Endpoint.allCouponsList), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
