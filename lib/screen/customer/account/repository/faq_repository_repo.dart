import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class CustomerFAQDataRepo {
  Future<http.Response> customerFaqData(token) async {
    try {
      return await http.get(Uri.parse(Endpoint.customerFaqData), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
