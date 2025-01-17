import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/view_all_seasonal_products_model.dart';

class AllSeasonalProductsRepo {
  Future<http.Response> getAllSeasonalProducts(
      AllSeasonalProductsReqModel reqModel, token) async {
    print(reqModel.toJson());
    print(token);
    try {
      return await http.post(Uri.parse(Endpoint.AllSeasonalProducts),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
