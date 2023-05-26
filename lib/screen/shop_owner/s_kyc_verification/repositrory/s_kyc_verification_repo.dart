import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/model/s_kyc_verification_model.dart';
class SKycVerificationRepo{

  Future<http.Response> sendKycDetails(ShopKycVerificationReqModel reqModel,token) async {
    try{
      return await http.post(Uri.parse(Endpoint.kycVerification),body: reqModel.toJson(),headers: {
        "Authorization": "Bearer $token",
        'Content-Type': 'application/json',
      });

    }
    catch(e){
      throw Exception(e);
    }
  }

}