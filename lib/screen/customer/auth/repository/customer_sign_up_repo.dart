import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/auth/model/customer_sign_up_model.dart';

class CustomerSignUpRepo {
  Future<http.Response> customerSignUpDetail(
      CustomerSignUpRequestModel requestModel, token) async {
    try {
      return await http.post(Uri.parse(Endpoint.customerSignup),
          body: requestModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
