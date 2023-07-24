import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class CustomerSignOutRepo {
  Future<http.Response> customerSignOut(token) async {
    print(token);
    try {
      return await http.post(Uri.parse(Endpoint.clogOut), headers: {
        "Authorization": "Bearer $token",
        'Content-Type': 'application/json',
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
