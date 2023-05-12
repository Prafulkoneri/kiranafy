import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/repository/subscription_plan_repo.dart';

class SSubscriptionController extends ChangeNotifier{
  SubscriptionPlansRepo subscriptionPlansRepo=SubscriptionPlansRepo();
  void onMakePaymentClicked(context){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>SMainScreenView()));
  }
  Future<void> getSubscriptionPlanDetails()async{

  }
}
