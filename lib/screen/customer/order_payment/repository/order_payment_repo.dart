import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/order_payment/model/order_payment_model.dart';

class OrderPaymentViewRepo {
  Future<http.Response> orderPayment(
      OrderPaymentReqModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.orderPayment));
    try {
      return await http.post(Uri.parse(Endpoint.orderPayment),
          body: reqModel.toJson(),
          headers: {
            "Authorization":
                "Bearer 490|hXQ8FaHt8jRecPyhgcuTPBylGJWLJGvuu4Nc0N2o",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
