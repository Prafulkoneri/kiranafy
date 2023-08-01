import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/new_model/edit_unit_product_category_model.dart';

class EditUnitProductCategoryRepo {
  Future<http.Response> getEditUnit(
      EditProductUnitCategoryRequestModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.editUnitProductCategory));
    try {
      return await http.post(Uri.parse(Endpoint.editUnitProductCategory),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
