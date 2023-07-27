import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/advertisement_form/model/c_ads_model.dart';


class CPraqmotionRequestRepo {
  Future<http.Response> cpramotionRequest(
      CustomerAdsRequestmodel reqModel, token) async {
    print("Pramotion");
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.customerAds));
    try {
      return await http.post(Uri.parse(Endpoint.customerAds),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
