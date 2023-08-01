import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class NOtificationRepo {
  Future<http.Response> notificationList(token) async {
    try {
      return await http.get(Uri.parse(Endpoint.shopNotificationList), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
