import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/shop_owner_register_model.dart';
class ShopOwnerRegisterRepo {
  Future<http.Response> shopOwnerRegistration(
      ShopOwnerRegisterReqModel reqModel) async {
    try{
      print(reqModel.toJson());
      return await http.post(Uri.parse(Endpoint.shopOwnerRegister),body: reqModel.toJson());
    }
    catch(e){
      throw Exception(e);
    }
  }
}