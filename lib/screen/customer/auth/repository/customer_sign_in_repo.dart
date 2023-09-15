import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/auth/model/customer_sign_in_model.dart';

class CustomerSignInRepo {
  Future<http.Response> customerSignIn(
      CustomerSignInReqModel requestModel) async {
    print(requestModel.toJson());
    try {
      return await http.post(
        Uri.parse(Endpoint.customerSignIn),
        body: requestModel.toJson(),
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
