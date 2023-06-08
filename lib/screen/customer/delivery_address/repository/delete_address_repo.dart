import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/delivery_address/model/delete_address_model.dart';

class DeleteAddressRepo {
  Future<http.Response> deleteAddress(
      DeleteDeliveryAddressRequestModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.deleteDeliveryAddress));
    try {
      return await http.post(Uri.parse(Endpoint.deleteDeliveryAddress),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
