
import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/model/shop_owner_delivered_refund_submit_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/model/shop_owner_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/model/shop_update_refund_model.dart';

class ShopUpdateDeliveredRefundRepo {
  Future<http.Response> shopUpdateRefund(
      ShopOwnerDeliveredRefundSubmitReqModel reqModel, token) async {
    print(reqModel.toJson());
    try {
      return await http.post(Uri.parse(Endpoint.shopOwnerDeliveredRefundUpdate),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
