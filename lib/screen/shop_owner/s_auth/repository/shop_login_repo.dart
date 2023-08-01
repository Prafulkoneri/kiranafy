import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/login_model.dart';

class ShopLoginRepo {
  Future<http.Response> shopLogin(LoginReqModel reqModel) async {
    print("common");
    print(reqModel.toJson());
    try {
      return await http.post(Uri.parse(Endpoint.shopOwnerLogin),
          body: reqModel.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }
}
