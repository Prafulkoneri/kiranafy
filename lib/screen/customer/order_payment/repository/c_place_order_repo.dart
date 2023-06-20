import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/order_payment/model/c_place_order_model.dart';

class PlaceOrderRepo {
  Future<http.Response> placeOrder(
      CustomerPlaceOrderReqModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.placeOrder));
    try {
      return await http.post(Uri.parse(Endpoint.placeOrder),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
