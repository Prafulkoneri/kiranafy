import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/upload_admin_product_model.dart';

class UploadAdminProductRepo {
  Future<http.Response> uploadAdminProduct(
      UploadAdminProductReqModel reqModel, token) async {
    print("infityyyyy");
    print(reqModel.toJson());
    print("infityyyyy");
    print(Uri.parse(Endpoint.uploadAdminProduct));
    try {
      return await http.post(Uri.parse(Endpoint.uploadAdminProduct),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
