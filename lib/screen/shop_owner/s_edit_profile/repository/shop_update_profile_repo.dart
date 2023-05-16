import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/model/shop_update_profile_model.dart';

class UpdateProfileRepo {
  Future<http.Response> UpdateProfile(
      ShopUpdateProfileReqModel reqModel) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.ShopUpdateAccountDetails));
    try {
      return await http.post(Uri.parse(Endpoint.ShopUpdateAccountDetails),
          body: reqModel.toJson(),
          headers: {
            "Authorization":
                "Bearer 1|6IsMSEsKCuGqH0aOHPhy8uAp3bMznB7PWGxbuhZ3",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
