import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class CustomerSetingRepo {
  Future<http.Response> shopSetting(token) async {
    try {
      return await http.get(Uri.parse(Endpoint.customerShopSetting), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
