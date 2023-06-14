import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/model/s_add_categories_model.dart';

class AddCategoryRepo {
  Future<http.Response> addCategory(
      SAddCategoriesReqModel reqModel, token) async {
    try {
      print(reqModel.toJson());
      return await http.post(Uri.parse(Endpoint.addCategory),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer ${token}",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
