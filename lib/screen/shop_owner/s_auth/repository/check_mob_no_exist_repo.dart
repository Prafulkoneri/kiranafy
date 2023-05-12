import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/check_mob_no_exist_model.dart';

class CheckMobileNoExistRepo {
  Future<http.Response> checkMobileNoExist(
      CheckMobNoExistReqModel reqModel) async {
    print(Uri.parse(Endpoint.shopOwnerRegisterMobileNo));
    try {
      return await http.post(Uri.parse(Endpoint.shopOwnerRegisterMobileNo),
          body: reqModel.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }
}
