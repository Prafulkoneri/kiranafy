import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class CDeleteAccountRepo {
  Future<http.Response> cdeleteAccount(token) async {
    print(token);
    try {
      return await http.post(Uri.parse(Endpoint.cdeleteAccount), headers: {
        "Authorization": "Bearer $token",
        'Content-Type': 'application/json',
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
