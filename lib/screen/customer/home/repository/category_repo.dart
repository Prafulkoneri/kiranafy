import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class AllCategoriesRepo {
  Future<http.Response> getCategory(token) async {
    print(Uri.parse(Endpoint.categoriesListForDashBoard));
    try {
      return await http.get(Uri.parse(Endpoint.categoriesListForDashBoard),
          // categoriesAsPerPincode
          // body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
