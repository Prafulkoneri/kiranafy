import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class CmsDataRepo {
  Future<http.Response> cmsData(token) async {
    try {
      return await http.get(Uri.parse(Endpoint.cmsFile), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
