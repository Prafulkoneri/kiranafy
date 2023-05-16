import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class SubscriptionPlansRepo {
  Future<http.Response> getSubscriptionPlans(token) async {
    try {
      return await http.get(Uri.parse(Endpoint.subscriptionPlan), headers: {
        // "Authorization": "Bearer $token",
        "Authorization": "Bearer 10|78G8mC9MzyuxNNvCKtc2n5luBAeG7fDcnpc6Qvcm",
        'Content-Type': 'application/json',
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
