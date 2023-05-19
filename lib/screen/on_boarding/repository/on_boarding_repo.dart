import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class OnBoardingRepo {
  Future<http.Response> onBoardingScreen() async {
    try {
      return await http.get(
        Uri.parse(Endpoint.onBoardingScreen),
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
