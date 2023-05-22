import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class AllFvrtShopsRepo {
  Future<http.Response> allfvrtShops(token) async {
    try {
      return await http
          .get(Uri.parse(Endpoint.customersAllfvrtShopd), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
