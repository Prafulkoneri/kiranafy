import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/promotion_request/model/promotion_request_model.dart';

class PraqmotionRequestRepo {
  Future<http.Response> pramotionRequest(
      PromotionRequestRequestModel reqModel, token) async {
    print("Pramotion");
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.pramotionRequest));
    try {
      return await http.post(Uri.parse(Endpoint.pramotionRequest),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
