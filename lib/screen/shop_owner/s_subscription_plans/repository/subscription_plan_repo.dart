import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
class SubscriptionPlansRepo{

  Future<http.Response> shopLogin() async {
    try{
      return await http.get(Uri.parse(Endpoint.subscriptionPlan));
    }
    catch(e){
      throw Exception(e);
    }
  }
}