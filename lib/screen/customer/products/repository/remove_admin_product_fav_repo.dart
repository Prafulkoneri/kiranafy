import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/products/model/remove_admin_product_from_fav_model.dart';

class RemoveAdminFvrtProductRepo {
  Future<http.Response> removeAdminProductRepo(
      RemoveAdminProductReqModel reqModel, token) async {
    print(reqModel.toJson());
    print(token);
    print(Endpoint.removeAdminProduct);
    try {
      return await http.post(Uri.parse(Endpoint.removeAdminProduct),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
