import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_setting/model/change_setting_model.dart';

class DeleteAccountRepo {
  Future<http.Response> deleteAccount(token) async {
    print(token);
    try {
      return await http.post(Uri.parse(Endpoint.shopDelete), headers: {
        "Authorization": "Bearer $token",
        'Content-Type': 'application/json',
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
