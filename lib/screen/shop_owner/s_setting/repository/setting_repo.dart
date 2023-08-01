import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class SeetingRepo {
  Future<http.Response> shopSetting(token) async {
    try {
      return await http.get(Uri.parse(Endpoint.shopSetting), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
