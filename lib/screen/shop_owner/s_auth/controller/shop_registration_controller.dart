import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/country_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/repository/registration_data_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/view/s_kyc_verification_view.dart';

class ShopRegistrationController extends ChangeNotifier{
  TextEditingController mobController =TextEditingController();
  RegistrationDataRepo registrationDataRepo=RegistrationDataRepo();
  List<CountryData> ? data;
  String message="";

  Future<void> initState()async{
    await getCountryList();
  }

  void onOtpSubmitBtnPressed(context){
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              SKycVerificationView()),
    );
  }

  Future<void> getCountryList()async{
    registrationDataRepo.getCountryList().then((response){
      print(response.body);
      if(response.statusCode==200){
        final result = GetCountryListResModel.fromJson(jsonDecode(response.body));
        print("checkMobNoExist ${response.body}");
        message = result.message ?? "";
        data=result.countryData;
      }
    }).onError((error, stackTrace) {
      debugPrint("error");
    });
  }
}