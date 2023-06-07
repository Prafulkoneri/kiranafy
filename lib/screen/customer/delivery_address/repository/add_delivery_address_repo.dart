import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/delivery_address/model/add_delivery_address_model.dart';

class AddDeliverAddressRepo {
  Future<http.Response> addDeliveryAdress(
      AddAddressRequestModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.addDeliveryAddressList));
    try {
      return await http.post(Uri.parse(Endpoint.addDeliveryAddressList),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
