import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/recommanded_products_model.dart';

class AllRecomandedRepo {
  Future<http.Response> getAllRecommandedRepo(
      RecommandedReqModel reqModel, token) async {
    print(reqModel.toJson());
    print(token);
    try {
      return await http.post(Uri.parse(Endpoint.AllRecommandedProducts),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
