import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/auth/model/customer_guest_login_model.dart';

class CustomerGuestLoginInRepo {
  Future<http.Response> customerGuestLoginIn(
      CustomerGuestLoginReqModel requestModel) async {
    print(requestModel.toJson());
    try {
      return await http.post(
        Uri.parse(Endpoint.customerGuestLogin),
        body: requestModel.toJson(),
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
