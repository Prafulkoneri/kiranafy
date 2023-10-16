
import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/model/shop_update_refund_model.dart';

class ShopUpdateRefundRepo {
  Future<http.Response> shopUpdateRefund(
      ShopUpdateRefundReqModel reqModel, token) async {
    print(Endpoint.shopOwnerRefundUpdate);
    print(reqModel.toJson());
    try {
      return await http.post(Uri.parse(Endpoint.shopOwnerRefundUpdate),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
