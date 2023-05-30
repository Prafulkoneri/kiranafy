import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/shop_add_product_list_model.dart';

class ShopAddProductRepo {
  Future<http.Response> shopAddProducts(
      ShopAddProductsListRequestModel reqModel, token) async {
    print(reqModel.toJson());
    try {
      return await http.post(Uri.parse(Endpoint.getallselectedproductlist),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
