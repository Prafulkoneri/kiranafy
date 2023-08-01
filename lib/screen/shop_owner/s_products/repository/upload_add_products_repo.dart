import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/upload_add_product_model.dart';

class UploadAddProductRepo {
  Future<http.Response> uploadAddProduct(
      UploadAddProductsRequestModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.uploadAddProducts));
    try {
      return await http.post(Uri.parse(Endpoint.uploadAddProducts),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
