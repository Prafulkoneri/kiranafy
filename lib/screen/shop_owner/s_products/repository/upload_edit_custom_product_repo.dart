import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/upload_custom_product_data_model.dart';

class UploadEditCustomProductRepo {
  Future<http.Response> uploadEditCustomProduct(
      UploadCustomProductReqModel reqModel, token) async {
    print("kkkkkkk");
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.updateEditCustomProduct));
    try {
      return await http.post(Uri.parse(Endpoint.updateEditCustomProduct),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
