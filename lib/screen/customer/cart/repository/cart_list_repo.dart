import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class ShopCartListRepo {
  Future<http.Response> cartList(token) async {
    print(Uri.parse(Endpoint.cartList));
    try {
      return await http.get(Uri.parse(Endpoint.cartList), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
