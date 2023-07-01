import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class SubscriptionHistoryRepo {
  Future<http.Response> subscriptionHistory(token) async {
    try {
      return await http.get(Uri.parse(Endpoint.subscriptionHistory), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
