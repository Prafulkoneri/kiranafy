import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/selected_products_model.dart';

class SSelectedProductsRepo {
  Future<http.Response> selectedProducts(
      SelecteProductsRequestModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.selectedProducts));
    try {
      return await http.post(Uri.parse(Endpoint.selectedProducts),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
