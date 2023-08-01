import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/new_model/s_get_product_unit_list_model.dart';

class GetUnitProductListRepo {
  Future<http.Response> getUnitProductList(
      GetProductUitListRequestModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.getProductUnitList));
    try {
      return await http.post(Uri.parse(Endpoint.getProductUnitList),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
