import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_my_subscription/model/subscription_invoice_model.dart';

class SubScreptionInvoiceRepo {
  Future<http.Response> subscriptionInvoice(
      ShopConfigrationInvoiceRequestModel reqModel, token) async {
    print(token);
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.subScreiptionInvoice));
    try {
      return await http.post(Uri.parse(Endpoint.subScreiptionInvoice),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
