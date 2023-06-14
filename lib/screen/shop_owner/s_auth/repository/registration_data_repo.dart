import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/area_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/city_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/country_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/pincode_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/state_model.dart';
import 'package:local_supper_market/utils/utils.dart';

class RegistrationDataRepo {
  Future<http.Response> getCountryList(context) async {
    try {
      return await http.get(Uri.parse(Endpoint.getCountryList));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> getStateList(GetStateListReqModel reqModel) async {
    try {
      return await http.post(Uri.parse(Endpoint.getStateList),
          body: reqModel.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> getCityList(GetCityListReqModel reqModel) async {
    try {
      return await http.post(Uri.parse(Endpoint.getCityList),
          body: reqModel.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> getAreaList(GetAreaListReqModel reqModel) async {
    try {
      return await http.post(Uri.parse(Endpoint.getAreaList),
          body: reqModel.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> getPincodeList(GetPincodeReqModel reqModel) async {
    try {
      return await http.post(Uri.parse(Endpoint.getPincodeList),
          body: reqModel.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }
}
