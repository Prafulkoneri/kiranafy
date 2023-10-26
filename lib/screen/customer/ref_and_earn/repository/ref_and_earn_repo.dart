import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';



class RefAndEarnRepo {
  Future<http.Response> getRefAndEarnData(token) async {
    print(token);
    try {
      return await http.get(Uri.parse(Endpoint.referAndEarn),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
