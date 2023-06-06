import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class CustomerListRepo {
  Future<http.Response> customerListRepo(token) async {
    try {
      return await http.get(Uri.parse(Endpoint.customerList), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
