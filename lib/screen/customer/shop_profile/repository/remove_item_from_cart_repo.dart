import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/remove_item_cart_model.dart';

class RemoveCartItemRepo {
  Future<http.Response> removeCartItem(
      RemoveItemFromCartReq reqModel, token) async {
    print(reqModel.toJson());
    print(token);
    try {
      return await http.post(Uri.parse(Endpoint.removeCartItem),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
