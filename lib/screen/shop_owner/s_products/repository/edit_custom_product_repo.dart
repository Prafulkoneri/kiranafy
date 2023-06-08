import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/edit_admin_custom_product_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/edit_custom_products_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/shop_add_product_list_model.dart';

class EditCustomProductRepo {
  Future<http.Response> getCustomProductDetails(
      EditCustomProductsRequestModel reqModel, token) async {
    print(token);
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.editCustomProduct));
    try {
      return await http.post(Uri.parse(Endpoint.editCustomProduct),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
