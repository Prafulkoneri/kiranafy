import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/delivery_view/model/customer_cancel_order_model.dart';

class CustomerCancelOrderRepo {
  Future<http.Response> customerCancelOrder(
      CustomerCancelOrderRequestModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.customerCancelOrder));
    try {
      return await http.post(Uri.parse(Endpoint.customerCancelOrder),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
