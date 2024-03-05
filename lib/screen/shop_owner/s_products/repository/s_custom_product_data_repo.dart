import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class SCustomProductDataRepo {
  Future<http.Response> customProductDataModel(token) async {
    try {
      return await http.get(Uri.parse(Endpoint.createCustomProduct), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
