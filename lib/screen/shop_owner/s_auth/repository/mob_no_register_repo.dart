import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/mobile_no_register_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/shop_owner_register_model.dart';
class MobileNoRegisterRepo {
  Future<http.Response> mobileNoRegister(
      MobNoRegisterReqModel reqModel) async {
    try{
      print(reqModel.toJson());
      return await http.post(Uri.parse(Endpoint.shopOwnerRegister),body: reqModel.toJson());
    }
    catch(e){
      throw Exception(e);
    }
  }
}