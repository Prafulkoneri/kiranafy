import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/edit_admin_custom_product_model.dart';

class EditAdminProductRepo {
  Future<http.Response> getAdminProductDetails(
      EditAdminProductReqModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.editAdminProducts));
    try {
      return await http.post(Uri.parse(Endpoint.editAdminProducts),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
