import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_payments/model/payment_history_model.dart';

class PaymentHistoryRepo {
  Future<http.Response> paymentHistory(
      PaymentHistoaryRequestModel reqModel, token) async {
    print(reqModel.toJson());
    try {
      return await http.post(Uri.parse(Endpoint.paymentHistory),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
