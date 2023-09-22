import 'dart:convert';
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
  String privacyPolicyHtml = "";
  String raw = "";
  bool isLoading=true;
  Future<void> initState(context) async {
    await getCmsPages(context);
  }
void showLoader(value){
    isLoading=value;
    notifyListeners();
}
  Future<void> getCmsPages(context) async {
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    cartListRepo.cmsData(pref.getString("successToken")).then((response) {
      print(response.body);
      final result = CmsModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("hellooo");
        print(cmsdata?.privacyPolicy?.description);
        cmsdata = result.cmsdata;
        aboutUs = cmsdata?.aboutUs;
        privacyPolicy = cmsdata?.privacyPolicy;
        privacyPolicyHtml = privacyPolicy?.description ?? "";
        termsAndCondition = cmsdata?.termsAndCondition;
        print("yrvuyuiweuiytuiwuivbyhiuyeruiyvuiweryiuy");
        print(termsAndCondition);
        raw = privacyPolicyHtml.replaceAll('\n', r'\n');
        showLoader(false);
        notifyListeners();
      } else {
        showLoader(false);
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      showLoader(false);
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
      (Object e) {
        showLoader(false);
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e) {
        showLoader(false);
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }
}
