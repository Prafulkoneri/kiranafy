import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/cart/model/cart_item_quantity_model.dart';

class CartItemQuantityRepo {
  Future<http.Response> cartItemQuantity(
      CartItemQuantityReqModel reqModel, token) async {
    print(token);
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.cartItemQuantity));
    try {
      return await http.post(Uri.parse(Endpoint.cartItemQuantity),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
