import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class FAQDataRepo {
  Future<http.Response> faqData(token) async {
    try {
      return await http.get(Uri.parse(Endpoint.faqData), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
