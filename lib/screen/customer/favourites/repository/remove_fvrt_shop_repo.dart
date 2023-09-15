import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/favourites/model/remove_fvrt_shops.dart';

class RemoveFvrtShopRepo {
  Future<http.Response> fvrtShops(
      RemoveFvrtShopReqModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.removeFrvtShops));
    try {
      return await http.post(Uri.parse(Endpoint.removeFrvtShops),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
