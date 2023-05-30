import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/shop_owner_register_model.dart';
import 'package:local_supper_market/utils/utils.dart';
class ShopOwnerRegisterRepo {
  Future<http.Response> shopOwnerRegistration(
      ShopOwnerRegisterReqModel reqModel,context) async {
    try{
      print(reqModel.toJson());
      return await http.post(Uri.parse(Endpoint.shopOwnerRegister),body: reqModel.toJson());
    }
    catch(e){
      Utils.showPrimarySnackbar(context, e , type: SnackType.error);
      throw Exception(e);
    }
  }
}