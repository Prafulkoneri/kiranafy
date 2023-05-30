import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class ShopEditProfileRepo {
  Future<http.Response> getShopEditProfileDetails(token) async {
    try {
      print(Endpoint.getShopEditProfileDetail);
      return await http.get(Uri.parse(Endpoint.getShopEditProfileDetail), headers: {
        "Authorization": "Bearer $token",
        'Content-Type': 'application/json',
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
