import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/repository/customer_view_shop_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
class ShopProfileController extends ChangeNotifier{
  String shopId="";
  CustomerViewShopRepo customerViewShopRepo=CustomerViewShopRepo();
  ShopData ? shopData;
  ShopDetails ? shopDetails;
  List<ShopCategory> ? shopCategory;
  Future<void> initState(context,id)async{

    await getShopDetails(context,id);
    notifyListeners();
  }

  CustomerViewShopReqModel get customerViewShopReqModel=>CustomerViewShopReqModel(
    shopId: shopId,
  );

  Future<void> getShopDetails(context,id)async{
    shopId=id;
    SharedPreferences pref=await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    customerViewShopRepo.getShopDetails(customerViewShopReqModel,pref.getString("successToken")).then((response){
      log("response.body${response.body}");
      final result =
      CustomerViewShopResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        shopData=result.data;
        shopDetails=shopData?.shopDetails;
        shopCategory=shopData?.shopCategories;
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

  void launchPhone(String mobNumber,context) async {
    var number =Uri.parse("tel:${mobNumber}");
    if (await canLaunchUrl(number)) {
      await launchUrl(number);
    } else {
      Utils.showPrimarySnackbar(context,"Unable to dial at the moment",
          type: SnackType.error);
    }
  }

}