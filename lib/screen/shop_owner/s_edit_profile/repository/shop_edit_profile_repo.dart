import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class ShopEditProfileRepo {
  Future<http.Response> getShopEditProfileDetails() async {
    try {
      return await http
          .get(Uri.parse(Endpoint.getShopEditProfileDetail), headers: {
        "Authorization": "Bearer 6|5EHy0ExJuBjXKdXqvkuwmVngPXfGQGzalC9EARa1",
        'Content-Type': 'application/json',
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
