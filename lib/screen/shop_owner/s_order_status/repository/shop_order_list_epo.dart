import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class ShopGetOrderListRepo {
  Future<http.Response> SGetOrderListModel(token) async {
    try {
      return await http.get(Uri.parse(Endpoint.shopGetOrderList), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
