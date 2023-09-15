import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class AllNearShopRepo {
  Future<http.Response> getAllNearShop(token) async {
    // print(.toJson());
    print("hdhdhdh");
    print(Uri.parse(Endpoint.allNearShopAsPerPincode));
    print("hdhdhdh");
    try {
      return await http
          .get(Uri.parse(Endpoint.allNearShopAsPerPincode), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
