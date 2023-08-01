import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/model/remove_product_from_order.dart';

class AddRemoveProductFromOrderRepo {
  Future<http.Response> addremoveProductFromOrder(
      AddRemoveProductFromOrderReqModel reqModel, token) async {
    print(reqModel.toJson());
    try {
      return await http.post(Uri.parse(Endpoint.shopOwnerAddRemoveProduct),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
