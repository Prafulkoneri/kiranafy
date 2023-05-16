import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
class SubscriptionPlansRepo{

  Future<http.Response> getSubscriptionPlans(token) async {
    print(token);
    try{
      return await http.get(Uri.parse(Endpoint.subscriptionPlan), headers: {
      "Authorization": "Bearer $token",
      'Content-Type': 'application/json',
      });
    }
    catch(e){
      throw Exception(e);
    }
  }
}