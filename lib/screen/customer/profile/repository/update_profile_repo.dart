import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/profile/model/update_profile_model.dart';

class CustomerUpdateProfileRepo {
  Future<http.Response> customerUpdateProfile(
      UpdateProfileDetailReqModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.customerUpdateProfile));
    try {
      return await http.post(Uri.parse(Endpoint.customerUpdateProfile),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
