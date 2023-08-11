import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/delivery_view/model/order_invoice_download_model.dart';

class OrderInvoiceRepo {
  Future<http.Response> orderInvoice(
      OrderInvoiceRequestModel reqModel, token) async {
    print(token);
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.orderInvoice));
    try {
      return await http.post(Uri.parse(Endpoint.orderInvoice),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
