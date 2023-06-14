import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/cart/model/cart_detail_delete_model.dart';

class CartDetailDeleteRepo {
  Future<http.Response> cartDetailDelete(
      CartDetailDeleteRequestModel reqModel, token) async {
    print(token);
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.cartDetailDelete));
    try {
      return await http.post(Uri.parse(Endpoint.cartDetailDelete),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
