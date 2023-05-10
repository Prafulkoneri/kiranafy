import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/country_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/state_model.dart';

class RegistrationDataRepo{
  Future<http.Response> getCountryList()async{
    try{
      return await http.get(Uri.parse(Endpoint.getCountryList));
    }
    catch(e){
      throw Exception(e);
    }
  }
  Future<http.Response> getStateList(GetStateListReqModel reqModel)async{
    try{
      return await http.post(Uri.parse(Endpoint.getStateList),body: reqModel.toJson());
    }
    catch(e){
      throw Exception(e);
    }
  }
  Future<http.Response> getCityList(GetStateListReqModel reqModel)async{
    try{
      return await http.post(Uri.parse(Endpoint.getStateList));
    }
    catch(e){
      throw Exception(e);
    }
  }
}