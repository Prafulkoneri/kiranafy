import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class CustomerTicketListRepo {
  Future<http.Response> cticketList(token) async {
    try {
      return await http.get(Uri.parse(Endpoint.customerTicketList), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
