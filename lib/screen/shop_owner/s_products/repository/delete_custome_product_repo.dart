import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/delete_admin_product_model.dart';

class DeleteCustomeProductRepo {
  Future<http.Response> deleteCustomeProduct(
      DeleteAdminProductReqModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.deleteCustomeProduct));
    try {
      return await http.post(Uri.parse(Endpoint.deleteCustomeProduct),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
