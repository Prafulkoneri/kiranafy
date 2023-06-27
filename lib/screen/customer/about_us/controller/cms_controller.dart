import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:local_supper_market/screen/customer/about_us/model/cms_model.dart';
import 'package:local_supper_market/screen/customer/about_us/repository/cms_repo.dart';

import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CmsController extends ChangeNotifier {
  CmsDataRepo cartListRepo = CmsDataRepo();
  CmsData? cmsdata;
  AboutUs? aboutUs;
  AboutUs? privacyPolicy;
  AboutUs? termsAndCondition;
  Future<void> initState(context) async {
    await getCmsPages(context);
  }

  Future<void> getCmsPages(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    cartListRepo.cmsData(pref.getString("successToken")).then((response) {
      print(response.body);
      final result = CmsModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        cmsdata = result.cmsdata;
        aboutUs = cmsdata?.aboutUs;
        privacyPolicy = cmsdata?.privacyPolicy;
        termsAndCondition = cmsdata?.termsAndCondition;
        notifyListeners();
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
