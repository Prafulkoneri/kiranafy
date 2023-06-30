import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/search_product_model.dart';

class SearchProductRepo {
  Future<http.Response> searchProduct(
      SearchProductRequestModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.searchProduct));
    try {
      return await http.post(Uri.parse(Endpoint.searchProduct),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
