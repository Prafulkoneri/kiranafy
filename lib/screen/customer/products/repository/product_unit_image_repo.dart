import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/products/model/product_unit_images_res_model.dart';

class ProductUnitImageRepo {
  Future<http.Response> productUnitImageRepo(
      UnitImagesRequestModel reqModel, token) async {
    print(reqModel.toJson());
    print(token);
    try {
      return await http.post(Uri.parse(Endpoint.ProductUnitImage),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
