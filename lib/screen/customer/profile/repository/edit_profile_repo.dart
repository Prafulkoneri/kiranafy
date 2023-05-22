import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class EditCustomerProfileRepo {
  Future<http.Response> editCustomerProfileRepo() async {
    // print(token);
    try {
      return await http.get(Uri.parse(Endpoint.editCustomerProfile), headers: {
        "Authorization": "Bearer 49|E8P7yS6A0F4hwmVEuBc7uUUjtQKNKdbJJvAXI2jT",
        // "Authorization": "Bearer $token"
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
