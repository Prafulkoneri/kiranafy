import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/home/model/category_model.dart';

class AllCategoriesRepo {
  Future<http.Response> allNearShopRepo(
      AllCategoriesReqModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.allCategories));
    try {
      return await http.post(Uri.parse(Endpoint.allCategories),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}