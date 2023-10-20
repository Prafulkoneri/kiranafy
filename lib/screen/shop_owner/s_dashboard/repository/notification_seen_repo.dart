import 'package:local_supper_market/network/end_points.dart';
import 'package:http/http.dart' as http;

class NotificationSeenRepo {
  Future<http.Response> notificationSeen(token) async {
    try {
      return await http.get(Uri.parse(Endpoint.notificationSeenRepo),
          headers: {"Authorization": "Bearer $token"});
    } catch (e) {
      print("exception in api");
      throw Exception(e);
    }
  }
}
