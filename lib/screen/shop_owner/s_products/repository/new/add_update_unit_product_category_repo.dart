import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/new_model/add_update_unit_product_model.dart';

class AddUpdateUnitProductCategoryRepo {
  Future<http.Response> addUpdateUnitProductCategory(
      AddUpdateUnitProductCategoryRequestModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.addUpadteUnitProductCategory));
    try {
      return await http.post(Uri.parse(Endpoint.addUpadteUnitProductCategory),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
