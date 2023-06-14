import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/model/shop_update_profile_model.dart';

class SCustomProductDataRepo {
  Future<http.Response> customProductDataModel(token) async {
    try {
      return await http.get(Uri.parse(Endpoint.createCustomProduct), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
