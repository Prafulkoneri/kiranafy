import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/utils/maps/model/map_model.dart';

class MapRepo {
  Future<http.Response> mapPincode(MapRequestModel reqModel, token) async {
    print(reqModel.toJson());
    try {
      return await http.post(Uri.parse(Endpoint.currentLocationPincode),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
