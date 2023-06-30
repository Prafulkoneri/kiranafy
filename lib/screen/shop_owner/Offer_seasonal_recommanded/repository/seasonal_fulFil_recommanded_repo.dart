import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class SRFProductListRepo {
  Future<http.Response> sRFProducts(token) async {
    print("hjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj");
    print(Endpoint.sRFProductsList);
    try {
      return await http.get(Uri.parse(Endpoint.sRFProductsList), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
