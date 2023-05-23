import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class CustomerProfileRepo {
  Future<http.Response> getCustomerProfile(token) async {
    try {
      return await http.get(Uri.parse(Endpoint.customerProfile), headers: {
        "Authorization": "Bearer $token",
        'Content-Type': 'application/json',
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
