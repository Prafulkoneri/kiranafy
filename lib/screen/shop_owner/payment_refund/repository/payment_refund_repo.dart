import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/payment_refund/model/payment_refund_list_model.dart';

class PaymentRefundListRepo {
  Future<http.Response> paymentRefund(
      ShopPaymentRefundListRequestModel reqModel, token) async {
    print(reqModel.toJson());
    try {
      return await http.post(Uri.parse(Endpoint.paymentRefundList),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
