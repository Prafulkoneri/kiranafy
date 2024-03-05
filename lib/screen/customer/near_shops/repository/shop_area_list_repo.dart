import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class ShopAreaListRepo {
  Future<http.Response> getShopAreaList(token) async {
    print(Uri.parse(Endpoint.getShopAreaList));
    try {
      return await http
          .post(Uri.parse(Endpoint.getShopAreaList), body: {}, headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
