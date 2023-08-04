import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class CDeleteNotificationRepo {
  Future<http.Response> cdeleteNotification(token) async {
    print(Uri.parse(Endpoint.customerNotificationDelete));
    try {
      return await http
          .get(Uri.parse(Endpoint.customerNotificationDelete), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
