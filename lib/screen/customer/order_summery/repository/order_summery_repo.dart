import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/order_summery/model/order_summery_model.dart';

class OrderSummeryRepo {
  Future<http.Response> viewOrderSummery(
      OrderSummeryReqModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.customerOrderSummery));
    try {
      return await http.post(Uri.parse(Endpoint.customerOrderSummery),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
