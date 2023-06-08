import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/delivery_address/model/update_address_model.dart';

class DeleteDeliveryAddressRepo {
  Future<http.Response> deleteDeliveryAddress(
      UpdateDeliveryAddressReqModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.UpdateDeliveryAddress));
    try {
      return await http.post(Uri.parse(Endpoint.UpdateDeliveryAddress),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
