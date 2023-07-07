import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/Offer_seasonal_recommanded/model/remove_srf_model.dart';
import 'package:local_supper_market/utils/url/model/get_url_model.dart';

// class GetUrlRepo {
//   Future<http.Response> getUrl(
//       GetUrlReqModel reqModel) async {
//     print(reqModel.toJson());
//     print(Uri.parse(Endpoint.getBaseUrl ));
//     try {
//       return await http.post(Uri.parse(Endpoint.getBaseUrl),
//           body: reqModel.toJson(),
//          );
//     } catch (e) {
//       throw Exception(e);
//     }
//   }
// }
