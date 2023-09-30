import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/auth/model/mobile_number_check_model.dart';

class MobileNumberCheckRepo {
  Future<http.Response> mobileNumberCheck(
      MobileNumberCheckRequestModel reqModel) async {
    print(Uri.parse(Endpoint.mobileNumberChecks));
    try {
      print(reqModel.toJson());
      return await http.post(Uri.parse(Endpoint.mobileNumberChecks),
          body: reqModel.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }
}
