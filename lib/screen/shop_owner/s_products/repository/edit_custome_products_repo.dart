import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/edit_custome_products_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/shop_add_product_list_model.dart';

class EditCustomeProductsRepo {
  Future<http.Response> editCustomeProducts(
      EditCustomeProductsRequestModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.editCustomeProducts));
    try {
      return await http.post(Uri.parse(Endpoint.editCustomeProducts),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
