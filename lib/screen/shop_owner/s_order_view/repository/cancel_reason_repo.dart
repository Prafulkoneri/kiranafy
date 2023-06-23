import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class OrderCancelReasonRepo {
  Future<http.Response> OrderCancelReason(token) async {
    try {
      return await http.get(Uri.parse(Endpoint.cancelOrderReason), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
