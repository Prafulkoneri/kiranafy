import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class UnitListToCreateProductRepo {
  Future<http.Response> unitListProductRepo(token) async {
    print(token);
    try {
      return await http
          .get(Uri.parse(Endpoint.unitListToCreateProduct), headers: {
        // "Authorization": "Bearer $token",
        "Authorization": "Bearer $token",
        'Content-Type': 'application/json',
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
