import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:local_supper_market/screen/shop_owner/promotion_request/model/promotion_request_model.dart';
import 'package:local_supper_market/screen/shop_owner/promotion_request/repository/promotion_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopPramotionController extends ChangeNotifier {
  String groupValue = "";
  TextEditingController pramotionRequestController = TextEditingController();
  TextEditingController planToStartController = TextEditingController();
  TextEditingController adsContentController = TextEditingController();
  PraqmotionRequestRepo pramotionRequestRepo = PraqmotionRequestRepo();
  PromotionRequestRequestModel get pramotionRequestRequestModel =>
      PromotionRequestRequestModel(
          adsPlan: groupValue,
          adsContent: adsContentController.text,
          planStartDateFromShopOwner: planToStartController.text,
          promotionSubject: pramotionRequestController.text);

  Future<void> shopRegister(context) async {
    print("object");
    SharedPreferences pref = await SharedPreferences.getInstance();
    pramotionRequestRepo
        .pramotionRequest(
            pramotionRequestRequestModel, pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result =
          PromotionRequestResponseModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
      (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }
}
