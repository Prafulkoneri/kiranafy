
import 'dart:io';


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:local_supper_market/network/services/firebase_api.dart';
import 'package:local_supper_market/screen/customer/account/view/controller/profile_controller.dart';

import 'package:local_supper_market/screen/customer/auth/controller/customer_sign_in_controller.dart';
import 'package:local_supper_market/screen/customer/auth/controller/customer_sign_up_controller.dart';
import 'package:local_supper_market/screen/customer/category/controller/product_as_per_category_controller.dart';
import 'package:local_supper_market/screen/customer/delivery_address/controller/add_address_controller.dart';

import 'package:local_supper_market/screen/customer/favourites/controller/favourites_controller.dart';
import 'package:local_supper_market/screen/customer/home/controller/home_screen_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/near_shops/controller/all_shop_category_controller.dart';
import 'package:local_supper_market/screen/customer/near_shops/controller/all_shop_controller.dart';
import 'package:local_supper_market/screen/customer/near_shops/view/all_near_shops_category_view.dart';
import 'package:local_supper_market/screen/customer/notifications/view/notification_view.dart';
import 'package:local_supper_market/screen/customer/order_summary/controller/order_summary_controller.dart';
import 'package:local_supper_market/screen/customer/shop_profile/controller/all_offers_controller.dart';
import 'package:local_supper_market/screen/customer/shop_profile/controller/recommanded_controller.dart';
import 'package:local_supper_market/screen/customer/shop_profile/controller/shop_profile_controller.dart';
import 'package:local_supper_market/screen/on_boarding/controller/on_boarding_controller.dart';
import 'package:local_supper_market/screen/shop_owner/customer_list/controller/s_customer_detail_controller.dart';
import 'package:local_supper_market/screen/shop_owner/customer_list/controller/s_customer_list_controller.dart';

import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/controller/s_account_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/controller/shop_registration_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/controller/shop_sign_in_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/view/shop_registration_view.dart';

import 'package:local_supper_market/screen/shop_owner/s_category_list/controller/s_category_list_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/controller/s_add_coupons_controller.dart';

import 'package:local_supper_market/screen/shop_owner/s_dashboard/controller/s_dashboard_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/controller/shop_edit_profile_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/controller/s_kyc_verrification_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/view/s_kyc_approved.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/view/s_kyc_completed.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';

import 'package:local_supper_market/screen/shop_owner/s_order_status/controller/s_order_Status_controller.dart';

import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/controller/new/s_add_edit_unit_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/controller/s_edit_admin_product_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/controller/s_edit_custom_product_controller.dart';

import 'package:local_supper_market/screen/shop_owner/s_select_category/controller/s_select_category_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_setting/controller/setting_controller.dart';

import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/controller/s_shop_configuration_controller.dart';

import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/controller/s_subscription_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/view/s_subscription_view.dart';

import 'package:local_supper_market/screen/splash/controller/splash_controller.dart';
import 'package:local_supper_market/screen/splash/view/splash_view.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'screen/customer/about_us/controller/cms_controller.dart';
import 'screen/customer/c_setting/controller/c_setting_controller.dart';
import 'screen/customer/cart/controller/cart_controller.dart';
import 'screen/customer/cart/controller/cart_detail_controller.dart';
import 'screen/customer/delivery_address/controller/delivery_address_controller.dart';
import 'screen/customer/delivery_view/controller/customer_order_view_controller.dart';
import 'screen/customer/my_order/controller/my_orders_controller.dart';
import 'screen/customer/near_shops/controller/all_near_shop_controller.dart';
import 'screen/customer/order_payment/controller/order_payment_controller.dart';
import 'screen/customer/order_status/controller/track_order_status_controller.dart';
import 'screen/customer/products/controller/product_view_controller.dart';
import 'screen/customer/profile/controller/edit_profile_controller.dart';
import 'screen/customer/shop_profile/controller/recommanded_controller.dart';
import 'screen/customer/shop_profile/controller/all_seasonal_controller.dart';
import 'screen/shop_owner/Offer_seasonal_recommanded/controller/offer_seasonal_recommanded_controller.dart';
import 'screen/shop_owner/bank_account_details/controller/get_bank_account_controll.dart';
import 'screen/shop_owner/help_center/controller/ticket_list_controller.dart';
import 'screen/shop_owner/help_center/controller/view_ticket_controller.dart';
import 'screen/shop_owner/notification/controller/notification_controller.dart';
import 'screen/shop_owner/promotion_request/controller/promotion_controller.dart';
import 'screen/shop_owner/s_coupons/controller/shop_coupons_list_controller.dart';
import 'screen/shop_owner/s_kyc_verification/view/s_kyc_verification_view.dart';
import 'screen/shop_owner/s_my_subscription/controller/subscription_history_controller.dart';
import 'screen/shop_owner/s_order_view/controller/shop_owner_order_view_controller.dart';
import 'screen/shop_owner/s_payments/controller/payment_histaory_controller.dart';
import 'screen/shop_owner/s_products/controller/new/get_product_unit_list_controller.dart';
import 'screen/shop_owner/s_products/controller/s_add_product_controller.dart';
import 'screen/shop_owner/s_products/controller/s_custom_product_controller.dart';
import 'screen/shop_owner/s_products/controller/s_selected_product_controller.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("handled background message");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBaOZbarFqV16r_fceIjrSAlNtgvddAFgg",
          appId: "1:110985117622:ios:1a970d32e1e8e861868b17",
          messagingSenderId: "110985117622",
          projectId: "lsm-0001"));
  } else {
    await Firebase.initializeApp();
  }
  await FireBaseApi().initNotification();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashController()),
        ChangeNotifierProvider(create: (_) => MainScreenController()),
        ChangeNotifierProvider(create: (_) => OnBoardingController()),
        ChangeNotifierProvider(create: (_) => CustomerSignInController()),
        ChangeNotifierProvider(create: (_) => CustomerSignUpController()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
        ChangeNotifierProvider(create: (_) => ShopRegistrationController()),
        ChangeNotifierProvider(create: (_) => ShopSignInController()),
        ChangeNotifierProvider(create: (_) => SKycVerificationController()),
        ChangeNotifierProvider(create: (_) => SSelectCategoryController()),
        ChangeNotifierProvider(create: (_) => SSubscriptionController()),
        ChangeNotifierProvider(create: (_) => SMainScreenController()),
        ChangeNotifierProvider(create: (_) => SDashBoardController()),
        ChangeNotifierProvider(create: (_) => SCategoryListController()),
        ChangeNotifierProvider(create: (_) => SAddProductsController()),
        ChangeNotifierProvider(create: (_) => PrimaryCheckBoxController()),
        ChangeNotifierProvider(create: (_) => SShopConfigurationController()),
        ChangeNotifierProvider(create: (_) => MobileNoController()),
        ChangeNotifierProvider(create: (_) => SOrderStatusController()),
        ChangeNotifierProvider(create: (_) => SAccountScreenController()),
        ChangeNotifierProvider(create: (_) => CustomProductController()),
        ChangeNotifierProvider(create: (_) => SSelectedProductsController()),
        ChangeNotifierProvider(create: (_) => UpdateProfileController()),
        ChangeNotifierProvider(create: (_) => HomeScreenController()),
        ChangeNotifierProvider(create: (_) => FavouritesController()),
        ChangeNotifierProvider(create: (_) => AllNearShopsAsPerPincode()),
        ChangeNotifierProvider(create: (_) => ShopProfileViewController()),
        ChangeNotifierProvider(create: (_) => AllShopController()),
        ChangeNotifierProvider(create: (_) => AllCategoryShopController()),
        ChangeNotifierProvider(create: (_) => ProductCategoryController()),
        ChangeNotifierProvider(create: (_) => ShopAllSeasonalController()),
        ChangeNotifierProvider(create: (_) => EditAdminProductController()),
        ChangeNotifierProvider(create: (_) => ProductViewController()),
        ChangeNotifierProvider(create: (_) => SCustomerListController()),
        ChangeNotifierProvider(
            create: (_) => SAllRecommandedProductsController()),
        ChangeNotifierProvider(
            create: (_) => ShopEditProfileDetailController()),
        ChangeNotifierProvider(create: (_) => SCustomerDetailController()),
        ChangeNotifierProvider(create: (_) => DeliveryAddressController()),
        ChangeNotifierProvider(create: (_) => AddAddressController()),
        ChangeNotifierProvider(create: (_) => SCouponsListController()),
        ChangeNotifierProvider(create: (_) => EditCustomProductController()),
        ChangeNotifierProvider(create: (_) => SAddCouponsController()),
        ChangeNotifierProvider(create: (_) => CartListController()),
        ChangeNotifierProvider(create: (_) => CartDetailController()),
        ChangeNotifierProvider(create: (_) => AllOffersController()),
        ChangeNotifierProvider(create: (_) => OrderSummaryController()),
        ChangeNotifierProvider(create: (_) => OrderPaymentController()),
        ChangeNotifierProvider(create: (_) => MyOrdersController()),
        ChangeNotifierProvider(create: (_) => ShopOwnerOrderViewController()),
        ChangeNotifierProvider(create: (_) => CustomerOrderViewController()),
        ChangeNotifierProvider(create: (_) => TrackOrderStatusController()),
        ChangeNotifierProvider(create: (_) => ShopSettingController()),
        ChangeNotifierProvider(create: (_) => CmsController()),
        ChangeNotifierProvider(create: (_) => shopPromotionController()),
        ChangeNotifierProvider(create: (_) => PaymentHistoryController()),
        ChangeNotifierProvider(create: (_) => SGetTicketListController()),
        ChangeNotifierProvider(create: (_) => ShopViewTicketController()),
        ChangeNotifierProvider(create: (_) => ShopViewTicketController()),
        ChangeNotifierProvider(create: (_) => SubscriptionHistoryController()),
        ChangeNotifierProvider(
            create: (_) => ShopSeasonalRecommandedOfferProductsController()),
        ChangeNotifierProvider(
            create: (_) => ShopSeasonalRecommandedOfferProductsController()),
        ChangeNotifierProvider(create: (_) => SBankAccountController()),
        ChangeNotifierProvider(create: (_) => SGetProductUnitListController()),
        ChangeNotifierProvider(create: (_) => CustomerSettingController()),
        ChangeNotifierProvider(create: (_) => AddEditUnitController()),
        ChangeNotifierProvider(create: (_) => ShopNoticationController()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

var fcmToken;
final firebaseMessaging = FirebaseMessaging.instance;

class _MyAppState extends State<MyApp> {
  @override

  void initState() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print(message.data);
      print("onMessageOpenedApp: $message");
      print("okkkkk");
      print(message.data["notification_type"]);
      if(message.data["notification_type"]=="custom"){

          context.read<SMainScreenController>().onCustomTypeNotification(context);

        
        
        // onTypeCustom();
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => SMainScreenView(
        //         index: 0,
        //         screenName: NotificationsScreenView(
        //
        //         ),
        //       )),
        //       (Route<dynamic> route) => false,
        // );
      }

    });


    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      print("onBackgroundMessage: $message");
    });

    // fireBaseApi();


  }


  void onTypeCustom(){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>NotificationsScreenView()));
  }

  void fireBaseApi() async {
    await firebaseMessaging.requestPermission();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("onMessageOpenedApp: $message");
    });
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      print("onBackgroundMessage: $message");
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Container(
              alignment: Alignment.center,
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: LoadingOverlay(
                  child: MaterialApp(
                      title: 'Flutter Demo',
                      theme: ThemeData(
                        primarySwatch: Colors.blue,
                        fontFamily: 'dm_sans_regular',
                      ),
                      // theme: ThemeData(
                      //   brightness: Brightness.light,
                      //   /* light theme settings */
                      // ),
                      // darkTheme: ThemeData(
                      //   brightness: Brightness.dark,
                      //   /* dark theme settings */
                      // ),
                      debugShowCheckedModeBanner: false,
                      home: SplashScreen()),
                ),
              ));
        });
  }
}    // ShopOrderStatusView()
