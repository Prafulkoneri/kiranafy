import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class ShopAllCategoriesRepo {
  Future<http.Response> shopAllCategoriesList() async {
    try {
      return await http.get(Uri.parse(Endpoint.categorieslist), headers: {
        "Authorization": "Bearer 7|gzVC2Sm1OLUy7pcRfPuXS8oGti47SlblBSTja7yq",
        'Content-Type': 'application/json',
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
