import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class BannerRepo {
  Future<http.Response> getBannerImage(token) async {
    try {
      return await http.get(Uri.parse(Endpoint.BannerAds), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
