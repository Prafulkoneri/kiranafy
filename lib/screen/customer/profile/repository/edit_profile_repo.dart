import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class EditCustomerProfileRepo {
  Future<http.Response> editCustomerProfileRepo(token) async {
    // print(token);
    try {
      return await http.get(Uri.parse(Endpoint.editCustomerProfile), headers: {
        "Authorization": "Bearer 64|Yk7plBiavkujPKFTOSe6NrVMJXDrzuADzP6NyPBB",
        // "Authorization": "Bearer $token"
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
