import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/my_order/model/my_order_model.dart';

class MyOrdersRepo {
  Future<http.Response> myOrders(MyOrdersRequestModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.myOrders));
    try {
      return await http.post(Uri.parse(Endpoint.myOrders),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
