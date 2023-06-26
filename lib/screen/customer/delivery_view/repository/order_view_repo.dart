import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/delivery_view/model/order_view_model.dart';

class OrderViewRepo {
  Future<http.Response> showOrderView(
      CustomerOrderViewRequestModel reqModel, token) async {
    print(token);
    print(reqModel.toJson());
    try {
      return await http.post(Uri.parse(Endpoint.customerOrderView),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
