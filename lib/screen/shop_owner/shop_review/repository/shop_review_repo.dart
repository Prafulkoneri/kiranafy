import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class ShopReviewListRepo {
  Future<http.Response> shopReview(token) async {
    print(token);
    try {
      return await http.get(Uri.parse(Endpoint.shopReviewList), headers: {
        "Authorization": "Bearer $token",
        'Content-Type': 'application/json',
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
