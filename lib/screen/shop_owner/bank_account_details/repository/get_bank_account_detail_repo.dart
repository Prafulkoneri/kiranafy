import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class GetBankAccountDetailRepo {
  Future<http.Response> getBankDetail(token) async {
    try {
      return await http.get(Uri.parse(Endpoint.getBankAccount), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
