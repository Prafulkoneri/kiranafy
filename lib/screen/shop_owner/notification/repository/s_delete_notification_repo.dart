import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class SDeleteNotificationRepo {
  Future<http.Response> sdeleteNotification(token) async {
    print(Uri.parse(Endpoint.shopNotificationDelete));
    try {
      return await http
          .get(Uri.parse(Endpoint.shopNotificationDelete), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
