import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/cart/model/cart_detail_model.dart';

class CartDetailRepo {
  Future<http.Response> cartDetailView(
      CartDetailRequestModel reqModel, token) async {
    print(token);
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.cartList));
    try {
      return await http.post(Uri.parse(Endpoint.cartDetailView),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
