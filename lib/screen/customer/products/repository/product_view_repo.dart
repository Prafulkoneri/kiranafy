import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/products/model/product_view_model.dart';

class ProductViewRepo {
  Future<http.Response> showProductsViewRepo(
      ProductViewRequestModel reqModel, token) async {
    print("qqqqqqqqqqqqqqqqqqqqqqqqqq");
    print(reqModel.toJson());
    print(token);
    try {
      return await http.post(Uri.parse(Endpoint.ProductView),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
