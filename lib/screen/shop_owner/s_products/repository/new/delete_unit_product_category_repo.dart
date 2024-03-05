import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/new_model/delete_product_unit_category_model.dart';

class DeleteUnitProductCategoryRepo {
  Future<http.Response> deleteUnitProductCategory(
      DeleteProductUnitCategoryRequestModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.deleteUnitProductCategory));
    try {
      return await http.post(Uri.parse(Endpoint.deleteUnitProductCategory),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
