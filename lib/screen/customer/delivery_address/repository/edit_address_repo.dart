import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/delivery_address/model/edit_address_model.dart';
import 'package:local_supper_market/screen/customer/delivery_address/model/mark_default_address_model.dart';

class EditAddressRepo {
  Future<http.Response> editAddress(
      EditDeliveryAddressRequestModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.editDeliveryAddress));
    try {
      return await http.post(Uri.parse(Endpoint.editDeliveryAddress),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
