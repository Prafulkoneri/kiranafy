import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/auth/model/mobile_number_check_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/check_mob_no_exist_model.dart';

class MobileNumberCheckRepo {
  Future<http.Response> mobileNumberCheck(
      MobileNumberCheckRequestModel reqModel) async {
    print(Uri.parse(Endpoint.mobileNumberChecks));
    try {
      return await http.post(Uri.parse(Endpoint.mobileNumberChecks),
          body: reqModel.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }
}
