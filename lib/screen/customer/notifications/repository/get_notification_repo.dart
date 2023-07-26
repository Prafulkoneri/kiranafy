import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class CustomerNotificationRepo {
  Future<http.Response> notificationList(token) async {
    try {
      return await http.get(Uri.parse(Endpoint.getCustomerNotificationList), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
