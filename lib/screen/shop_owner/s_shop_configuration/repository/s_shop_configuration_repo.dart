import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class ShopConfigurationRepo {
  Future<http.Response> shopCongurationDetails(token) async {
    try {
      return await http.get(Uri.parse(Endpoint.getShopConfiguration), headers: {
        "Authorization": "Bearer $token",
        'Content-Type': 'application/json',
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
