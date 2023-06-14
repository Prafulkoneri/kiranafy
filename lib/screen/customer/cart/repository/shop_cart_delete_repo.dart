import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class ShopCartDeleteRepo {
  Future<http.Response> deleteShopCart(token) async {
    print(Uri.parse(Endpoint.shopCartDelete));
    try {
      return await http.get(Uri.parse(Endpoint.shopCartDelete), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
