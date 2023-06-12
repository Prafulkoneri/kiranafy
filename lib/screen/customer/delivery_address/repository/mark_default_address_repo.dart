import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/delivery_address/model/mark_default_address_model.dart';

class DefaultAddressRepo {
  Future<http.Response> markDefaultAddress(
      DefaultAddressRequestModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.markDefaultaddress));
    try {
      return await http.post(Uri.parse(Endpoint.markDefaultaddress),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
