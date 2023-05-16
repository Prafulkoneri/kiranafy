import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/model/s_subscription_plans_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/repository/subscription_plan_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SSubscriptionController extends ChangeNotifier{
  SubscriptionPlansRepo subscriptionPlansRepo=SubscriptionPlansRepo();
  List<SubscriptionData> ? subscriptionData;

  Future<void> initState(context)async{
    await getSubscriptionPlanDetails(context);
  }


  void onMakePaymentClicked(context){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>SMainScreenView()));
  }
  Future<void> getSubscriptionPlanDetails(context)async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    subscriptionPlansRepo.getSubscriptionPlans("5|XkqvWDZhM5U2IgTVXVEmTQHXgTP88WALbk6fGK6O").then((response){

      final result = ShopSubscriptionPlansResModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        subscriptionData=result.subscriptionData;
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

