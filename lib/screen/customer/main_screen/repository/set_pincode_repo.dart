import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/main_screen/model/set_pincode_model.dart';
import 'package:local_supper_market/screen/customer/my_order/model/my_order_model.dart';

class SetPincodeRepo {
  Future<http.Response> setPincode(SetPincodeReqModel reqModel, token) async {
    print("7777777777");
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.setPincode));
    try {
      return await http.post(Uri.parse(Endpoint.setPincode),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
