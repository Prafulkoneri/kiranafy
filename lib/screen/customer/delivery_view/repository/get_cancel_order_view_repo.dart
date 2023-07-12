import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class GetCustomerCancelOrderRepo {
  Future<http.Response> cOrderCancelReason(token) async {
    print(token);
    // print(body.toJson());
    try {
      return await http
          .get(Uri.parse(Endpoint.getCustomerCancelOrder), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
