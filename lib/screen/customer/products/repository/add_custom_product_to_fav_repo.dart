import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/products/model/add_admin_product_to_fav_model.dart';
import 'package:local_supper_market/screen/customer/products/model/add_custom_product_to_fav_model.dart';
import 'package:local_supper_market/screen/customer/products/model/product_unit_images_res_model.dart';

class AddCustomProductToFavRepo {
  Future<http.Response> addCustomeProductToFav(
      AddCustomProductToFavReqModel reqModel, token) async {
    print(reqModel.toJson());
    print("oooooooooooooooooooooooooooooooo");
    print(token);
    try {
      return await http.post(Uri.parse(Endpoint.addCustomProductToFav),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
