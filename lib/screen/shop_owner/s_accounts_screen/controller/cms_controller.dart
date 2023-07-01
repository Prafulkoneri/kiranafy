import 'dart:convert';
import 'dart:developer';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/model/faq_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/repository/faq_repo.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:local_supper_market/screen/customer/about_us/model/cms_model.dart';
import 'package:local_supper_market/screen/customer/about_us/repository/cms_repo.dart';

import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CmsController extends ChangeNotifier {
  CmsDataRepo cmsDataRepo = CmsDataRepo();
  FAQDataRepo faqData = FAQDataRepo(); //
  CmsData? cmsdata;
  AboutUs? aboutUs;
  AboutUs? privacyPolicy;
  AboutUs? termsAndCondition;
  List<FaqData>? faqdata;
  Future<void> initState(context) async {
    await getCmsPages(context);
    // await getFAQData(context);
  }

  Future<void> getCmsPages(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    cmsDataRepo.cmsData(pref.getString("successToken")).then((response) {
      log(response.body);
      final result = CmsModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        cmsdata = result.cmsdata;
        aboutUs = cmsdata?.aboutUs;
        privacyPolicy = cmsdata?.privacyPolicy;
        print("3q2423424");
        print(privacyPolicy?.description);
        print("3q2423424");
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

  ////////////////////////////////////////////////////////////////////
  // Future<void> getFAQData(context) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   print(pref.getString("successToken"));
  //   faqData.faqData(pref.getString("successToken")).then((response) {
  //     log(response.body);
  //     final result = FaqModel.fromJson(jsonDecode(response.body));
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       faqdata = result.faqdata;
  //       print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
  //       print(faqdata);
  //       // cmsdata = result.cmsdata;
  //       // aboutUs = cmsdata?.aboutUs;
  //       // privacyPolicy = cmsdata?.privacyPolicy;
  //       // print("3q2423424");
  //       // print(privacyPolicy?.description);
  //       // print("3q2423424");
  //       // termsAndCondition = cmsdata?.termsAndCondition;
  //       notifyListeners();
  //     } else {
  //       Utils.showPrimarySnackbar(context, result.message,
  //           type: SnackType.error);
  //     }
  //   }).onError((error, stackTrace) {
  //     Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
  //   }).catchError(
  //     (Object e) {
  //       Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
  //     },
  //     test: (Object e) {
  //       Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
  //       return false;
  //     },
  //   );
  // }
}
