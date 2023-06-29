import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/bank_account_details/model/update_account_detail.dart';

class UpdateAddAccountDetailRepo {
  Future<http.Response> upadteAccount(
      BankAccountUpadateRequestModel reqModel, token) async {
    print("Pramotion");
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.updateBankDetail));
    try {
      return await http.post(Uri.parse(Endpoint.updateBankDetail),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
