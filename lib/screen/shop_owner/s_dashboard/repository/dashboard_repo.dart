import 'package:local_supper_market/network/end_points.dart';
import 'package:http/http.dart' as http;

class DashBoardRepo {
  Future<http.Response> getDashboardData(token) async {
    try {
      return await http.get(Uri.parse(Endpoint.ShopDashBoard),
          headers: {"Authorization": "Bearer $token"});
    } catch (e) {
      throw Exception(e);
    }
  }
}
