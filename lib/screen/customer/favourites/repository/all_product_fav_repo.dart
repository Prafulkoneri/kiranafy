import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class AllFvrtProductRepo {
  Future<http.Response> allfvrtProductRepo(token) async {
    try {
      return await http.get(Uri.parse(Endpoint.allFavProduct), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
