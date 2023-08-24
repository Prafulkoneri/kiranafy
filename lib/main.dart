import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:local_supper_market/bottom_navigation/controller/bottom_nav_controller.dart';
import 'package:local_supper_market/network/services/firebase_api.dart';
import 'package:local_supper_market/screen/customer/account/controller/profile_controller.dart';
import 'package:local_supper_market/screen/customer/auth/controller/customer_sign_in_controller.dart';
import 'package:local_supper_market/screen/customer/auth/controller/customer_sign_up_controller.dart';
import 'package:local_supper_market/screen/customer/category/controller/product_as_per_category_controller.dart';
import 'package:local_supper_market/screen/customer/coupons/controller/coupon_all_controler.dart';
import 'package:local_supper_market/screen/customer/delivery_address/controller/add_address_controller.dart';
import 'package:local_supper_market/screen/customer/favourites/controller/favourites_controller.dart';
import 'package:local_supper_market/screen/customer/help_center/controller/ticket_list_controller.dart';
import 'package:local_supper_market/screen/customer/help_center/controller/view_ticket_controller.dart';
import 'package:local_supper_market/screen/customer/home/controller/home_screen_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/near_shops/controller/all_shop_category_controller.dart';
import 'package:local_supper_market/screen/customer/near_shops/controller/all_shop_controller.dart';
import 'package:local_supper_market/screen/customer/near_shops/view/all_near_shops_category_view.dart';
import 'package:local_supper_market/screen/customer/notifications/controller/notification_controller.dart';
import 'package:local_supper_market/screen/customer/notifications/view/notification_view.dart';
import 'package:local_supper_market/screen/customer/order_summary/controller/order_summary_controller.dart';
import 'package:local_supper_market/screen/customer/return/controller/return_view_controller.dart';
import 'package:local_supper_market/screen/customer/shop_profile/controller/all_offers_controller.dart';
import 'package:local_supper_market/screen/customer/shop_profile/controller/recommanded_controller.dart';
import 'package:local_supper_market/screen/customer/shop_profile/controller/shop_profile_controller.dart';
import 'package:local_supper_market/screen/customer/update_profile/controller/edit_profile_controller.dart';
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
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'screen/customer/about_us/controller/cms_controller.dart';
import 'screen/customer/advertisement_form/controller/ads_controller.dart';
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

import 'screen/customer/review/controller/customer_review_list_shop_controller.dart';
import 'screen/customer/shop_profile/controller/recommanded_controller.dart';
import 'screen/customer/shop_profile/controller/all_seasonal_controller.dart';
import 'screen/shop_owner/Offer_seasonal_recommanded/controller/offer_seasonal_recommanded_controller.dart';
import 'screen/shop_owner/bank_account_details/controller/get_bank_account_controll.dart';
import 'screen/shop_owner/help_center/controller/ticket_list_controller.dart';
import 'screen/shop_owner/help_center/controller/view_ticket_controller.dart';
import 'screen/shop_owner/notification/controller/notification_controller.dart';
import 'screen/shop_owner/payment_refund/controller/payment_refund_controller.dart';
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
import 'screen/shop_owner/shop_review/controller/shop_review_controller.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("handled background message");
}

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final navigatorKey = GlobalKey<NavigatorState>();
String? selectedNotificationPayload;

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}

// Future<void> initNotification(context) async {
// // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('mipmap/ic_launcher');
//   final IOSInitializationSettings initializationSettingsIOS =
//       IOSInitializationSettings();
//   final MacOSInitializationSettings initializationSettingsMacOS =
//       MacOSInitializationSettings();
//   final InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//       macOS: initializationSettingsMacOS);
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//       onSelectNotification: (String? payload) {
//     print("nnnnnnnnnnnnnnnnnn");

//     print(payload);
//     var res = jsonDecode(payload.toString());
//     print(res["data"]["user_type"]);
//     if (res["data"] == "shop_owner") {
//       context
//           .read<SMainScreenController>()
//           .onOrderTypeNotification(context, res["data"]["redirect_id"]);
//     }
//     if (res["data"] == "customer") {
//       context
//           .read<MainScreenController>()
//           .onOrderTypeNotification(context, res["data"]["redirect_id"]);
//     }
//     print("lllllllllllllllllllll");
//     if (payload != null) OpenFile.open(payload);
//   });
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
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
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  // FlutterLocalNotificationsPlugin();

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
        ChangeNotifierProvider(create: (_) => TicketController()),
        ChangeNotifierProvider(create: (_) => GetTicketListController()),
        ChangeNotifierProvider(create: (_) => CustomerReviewListControler()),
        ChangeNotifierProvider(create: (_) => CustomerNoticationController()),
        ChangeNotifierProvider(create: (_) => customerAdscontroller()),
        ChangeNotifierProvider(create: (_) => BottomNavigationController()),
        ChangeNotifierProvider(create: (_) => CAllCouponController()),
        ChangeNotifierProvider(create: (_) => ReturnOrderController()),
        ChangeNotifierProvider(create: (_) => PaymentRefundListController()),
        ChangeNotifierProvider(create: (_) => SShopReviewListController()),
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
    Future<void> initNotification(context) async {
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('mipmap/ic_launcher');
      final IOSInitializationSettings initializationSettingsIOS =
          IOSInitializationSettings();
      final MacOSInitializationSettings initializationSettingsMacOS =
          MacOSInitializationSettings();
      final InitializationSettings initializationSettings =
          InitializationSettings(
              android: initializationSettingsAndroid,
              iOS: initializationSettingsIOS,
              macOS: initializationSettingsMacOS);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: (String? payload) {
        print("nnnnnnnnnnnnnnnnnn");

        print(payload);
        var res = jsonDecode(payload.toString());
        print(res["data"]["user_type"]);
        if (res["data"] == "shop_owner") {
          context
              .read<SMainScreenController>()
              .onOrderTypeNotification(context, res["data"]["redirect_id"]);
        }
        if (res["data"] == "customer") {
          context
              .read<MainScreenController>()
              .onOrderTypeNotification(context, res["data"]["redirect_id"]);
        }
        print("lllllllllllllllllllll");
        if (payload != null) OpenFile.open(payload);
      });
    }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print(message.data);
      print("onMessageOpenedApp: $message");
      print("okkkkk");

      ////////////Shop Notification Navigation /////////////////////
      print(message.data["notification_type"]);
      if (message.data["notification_type"] == "custom") {
        context.read<SMainScreenController>().onCustomTypeNotification(context);
      }
      if (message.data["notification_type"] == "order") {
        context
            .read<SMainScreenController>()
            .onOrderTypeNotification(context, message.data["redirect_id"]);
      }
    });

    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      print("onBackgroundMessage: $message");
    });

    // fireBaseApi();
  }

  Future<void> _showNotification(fileName, savePath) async {
    final android = AndroidNotificationDetails('0', 'Adun Accounts',
        channelDescription: 'channel description',
        importance: Importance.max,
        icon: '');
    final iOS = IOSNotificationDetails();
    final platform = NotificationDetails(android: android, iOS: iOS);

    await flutterLocalNotificationsPlugin.show(
        0, // notification id
        "${fileName}",
        'Download complete.',
        platform,
        payload: '$savePath');
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
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
                    debugShowCheckedModeBanner: false,
                    home: SplashScreen(),
                    // initialRoute: '/',
                    //   routes: {
                    //       '/':(context)=>SplashScreen(),

                    //   },
                  ),
                ),
              ));
        });
  }
}    // ShopOrderStatusView()
////////////////
// import 'dart:convert';
// import 'dart:io';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:loader_overlay/loader_overlay.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:local_supper_market/bottom_navigation/controller/bottom_nav_controller.dart';
// import 'package:local_supper_market/network/services/firebase_api.dart';
// import 'package:local_supper_market/screen/customer/account/controller/profile_controller.dart';
// import 'package:local_supper_market/screen/customer/auth/controller/customer_sign_in_controller.dart';
// import 'package:local_supper_market/screen/customer/auth/controller/customer_sign_up_controller.dart';
// import 'package:local_supper_market/screen/customer/category/controller/product_as_per_category_controller.dart';
// import 'package:local_supper_market/screen/customer/coupons/controller/coupon_all_controler.dart';
// import 'package:local_supper_market/screen/customer/delivery_address/controller/add_address_controller.dart';
// import 'package:local_supper_market/screen/customer/favourites/controller/favourites_controller.dart';
// import 'package:local_supper_market/screen/customer/help_center/controller/ticket_list_controller.dart';
// import 'package:local_supper_market/screen/customer/help_center/controller/view_ticket_controller.dart';
// import 'package:local_supper_market/screen/customer/home/controller/home_screen_controller.dart';
// import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
// import 'package:local_supper_market/screen/customer/near_shops/controller/all_shop_category_controller.dart';
// import 'package:local_supper_market/screen/customer/near_shops/controller/all_shop_controller.dart';
// import 'package:local_supper_market/screen/customer/near_shops/view/all_near_shops_category_view.dart';
// import 'package:local_supper_market/screen/customer/notifications/controller/notification_controller.dart';
// import 'package:local_supper_market/screen/customer/notifications/view/notification_view.dart';
// import 'package:local_supper_market/screen/customer/order_summary/controller/order_summary_controller.dart';
// import 'package:local_supper_market/screen/customer/return/controller/return_view_controller.dart';
// import 'package:local_supper_market/screen/customer/shop_profile/controller/all_offers_controller.dart';
// import 'package:local_supper_market/screen/customer/shop_profile/controller/recommanded_controller.dart';
// import 'package:local_supper_market/screen/customer/shop_profile/controller/shop_profile_controller.dart';
// import 'package:local_supper_market/screen/customer/update_profile/controller/edit_profile_controller.dart';
// import 'package:local_supper_market/screen/on_boarding/controller/on_boarding_controller.dart';
// import 'package:local_supper_market/screen/shop_owner/customer_list/controller/s_customer_detail_controller.dart';
// import 'package:local_supper_market/screen/shop_owner/customer_list/controller/s_customer_list_controller.dart';
// import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/controller/s_account_screen_controller.dart';
// import 'package:local_supper_market/screen/shop_owner/s_auth/controller/shop_registration_controller.dart';
// import 'package:local_supper_market/screen/shop_owner/s_auth/controller/shop_sign_in_controller.dart';
// import 'package:local_supper_market/screen/shop_owner/s_auth/view/shop_registration_view.dart';
// import 'package:local_supper_market/screen/shop_owner/s_category_list/controller/s_category_list_controller.dart';
// import 'package:local_supper_market/screen/shop_owner/s_coupons/controller/s_add_coupons_controller.dart';
// import 'package:local_supper_market/screen/shop_owner/s_dashboard/controller/s_dashboard_controller.dart';
// import 'package:local_supper_market/screen/shop_owner/s_edit_profile/controller/shop_edit_profile_controller.dart';
// import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/controller/s_kyc_verrification_controller.dart';
// import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/view/s_kyc_approved.dart';
// import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/view/s_kyc_completed.dart';
// import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
// import 'package:local_supper_market/screen/shop_owner/s_order_status/controller/s_order_Status_controller.dart';
// import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
// import 'package:local_supper_market/screen/shop_owner/s_products/controller/new/s_add_edit_unit_controller.dart';
// import 'package:local_supper_market/screen/shop_owner/s_products/controller/s_edit_admin_product_controller.dart';
// import 'package:local_supper_market/screen/shop_owner/s_products/controller/s_edit_custom_product_controller.dart';
// import 'package:local_supper_market/screen/shop_owner/s_select_category/controller/s_select_category_controller.dart';
// import 'package:local_supper_market/screen/shop_owner/s_setting/controller/setting_controller.dart';
// import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/controller/s_shop_configuration_controller.dart';
// import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/controller/s_subscription_controller.dart';
// import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/view/s_subscription_view.dart';
// import 'package:local_supper_market/screen/splash/controller/splash_controller.dart';
// import 'package:local_supper_market/screen/splash/view/splash_view.dart';
// import 'package:local_supper_market/widget/checkbox.dart';
// import 'package:local_supper_market/widget/loaderoverlay.dart';
// import 'package:local_supper_market/widget/textfield.dart';
// import 'package:open_file/open_file.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// import 'screen/customer/about_us/controller/cms_controller.dart';
// import 'screen/customer/advertisement_form/controller/ads_controller.dart';
// import 'screen/customer/c_setting/controller/c_setting_controller.dart';
// import 'screen/customer/cart/controller/cart_controller.dart';
// import 'screen/customer/cart/controller/cart_detail_controller.dart';
// import 'screen/customer/delivery_address/controller/delivery_address_controller.dart';
// import 'screen/customer/delivery_view/controller/customer_order_view_controller.dart';
// import 'screen/customer/my_order/controller/my_orders_controller.dart';
// import 'screen/customer/near_shops/controller/all_near_shop_controller.dart';
// import 'screen/customer/order_payment/controller/order_payment_controller.dart';
// import 'screen/customer/order_status/controller/track_order_status_controller.dart';
// import 'screen/customer/products/controller/product_view_controller.dart';

// import 'screen/customer/review/controller/customer_review_list_shop_controller.dart';
// import 'screen/customer/shop_profile/controller/recommanded_controller.dart';
// import 'screen/customer/shop_profile/controller/all_seasonal_controller.dart';
// import 'screen/shop_owner/Offer_seasonal_recommanded/controller/offer_seasonal_recommanded_controller.dart';
// import 'screen/shop_owner/bank_account_details/controller/get_bank_account_controll.dart';
// import 'screen/shop_owner/help_center/controller/ticket_list_controller.dart';
// import 'screen/shop_owner/help_center/controller/view_ticket_controller.dart';
// import 'screen/shop_owner/notification/controller/notification_controller.dart';
// import 'screen/shop_owner/payment_refund/controller/payment_refund_controller.dart';
// import 'screen/shop_owner/promotion_request/controller/promotion_controller.dart';
// import 'screen/shop_owner/s_coupons/controller/shop_coupons_list_controller.dart';
// import 'screen/shop_owner/s_kyc_verification/view/s_kyc_verification_view.dart';
// import 'screen/shop_owner/s_my_subscription/controller/subscription_history_controller.dart';
// import 'screen/shop_owner/s_order_view/controller/shop_owner_order_view_controller.dart';
// import 'screen/shop_owner/s_payments/controller/payment_histaory_controller.dart';
// import 'screen/shop_owner/s_products/controller/new/get_product_unit_list_controller.dart';
// import 'screen/shop_owner/s_products/controller/s_add_product_controller.dart';
// import 'screen/shop_owner/s_products/controller/s_custom_product_controller.dart';
// import 'screen/shop_owner/s_products/controller/s_selected_product_controller.dart';
// import 'screen/shop_owner/shop_review/controller/shop_review_controller.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("handled background message");
// }

// final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// final navigatorKey = GlobalKey<NavigatorState>();
// String? selectedNotificationPayload;

// class ReceivedNotification {
//   ReceivedNotification({
//     required this.id,
//     required this.title,
//     required this.body,
//     required this.payload,
//   });

//   final int id;
//   final String title;
//   final String body;
//   final String payload;
// }

// // Future<void> initNotification(context) async {
// // // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
// //   const AndroidInitializationSettings initializationSettingsAndroid =
// //       AndroidInitializationSettings('mipmap/ic_launcher');
// //   final IOSInitializationSettings initializationSettingsIOS =
// //       IOSInitializationSettings();
// //   final MacOSInitializationSettings initializationSettingsMacOS =
// //       MacOSInitializationSettings();
// //   final InitializationSettings initializationSettings = InitializationSettings(
// //       android: initializationSettingsAndroid,
// //       iOS: initializationSettingsIOS,
// //       macOS: initializationSettingsMacOS);
// //   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
// //       onSelectNotification: (String? payload) {
// //     print("nnnnnnnnnnnnnnnnnn");

// //     print(payload);
// //     var res = jsonDecode(payload.toString());
// //     print(res["data"]["user_type"]);
// //     if (res["data"] == "shop_owner") {
// //       context
// //           .read<SMainScreenController>()
// //           .onOrderTypeNotification(context, res["data"]["redirect_id"]);
// //     }
// //     if (res["data"] == "customer") {
// //       context
// //           .read<MainScreenController>()
// //           .onOrderTypeNotification(context, res["data"]["redirect_id"]);
// //     }
// //     print("lllllllllllllllllllll");
// //     if (payload != null) OpenFile.open(payload);
// //   });
// // }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await FlutterDownloader.initialize();
//   if (Platform.isIOS) {
//     await Firebase.initializeApp(
//         options: FirebaseOptions(
//             apiKey: "AIzaSyBaOZbarFqV16r_fceIjrSAlNtgvddAFgg",
//             appId: "1:110985117622:ios:1a970d32e1e8e861868b17",
//             messagingSenderId: "110985117622",
//             projectId: "lsm-0001"));
//   } else {
//     await Firebase.initializeApp();
//   }
//   await FireBaseApi().initNotification();
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');

//   // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   // FlutterLocalNotificationsPlugin();

//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => SplashController()),
//         ChangeNotifierProvider(create: (_) => MainScreenController()),
//         ChangeNotifierProvider(create: (_) => OnBoardingController()),
//         ChangeNotifierProvider(create: (_) => CustomerSignInController()),
//         ChangeNotifierProvider(create: (_) => CustomerSignUpController()),
//         ChangeNotifierProvider(create: (_) => ProfileController()),
//         ChangeNotifierProvider(create: (_) => ShopRegistrationController()),
//         ChangeNotifierProvider(create: (_) => ShopSignInController()),
//         ChangeNotifierProvider(create: (_) => SKycVerificationController()),
//         ChangeNotifierProvider(create: (_) => SSelectCategoryController()),
//         ChangeNotifierProvider(create: (_) => SSubscriptionController()),
//         ChangeNotifierProvider(create: (_) => SMainScreenController()),
//         ChangeNotifierProvider(create: (_) => SDashBoardController()),
//         ChangeNotifierProvider(create: (_) => SCategoryListController()),
//         ChangeNotifierProvider(create: (_) => SAddProductsController()),
//         ChangeNotifierProvider(create: (_) => PrimaryCheckBoxController()),
//         ChangeNotifierProvider(create: (_) => SShopConfigurationController()),
//         ChangeNotifierProvider(create: (_) => MobileNoController()),
//         ChangeNotifierProvider(create: (_) => SOrderStatusController()),
//         ChangeNotifierProvider(create: (_) => SAccountScreenController()),
//         ChangeNotifierProvider(create: (_) => CustomProductController()),
//         ChangeNotifierProvider(create: (_) => SSelectedProductsController()),
//         ChangeNotifierProvider(create: (_) => UpdateProfileController()),
//         ChangeNotifierProvider(create: (_) => HomeScreenController()),
//         ChangeNotifierProvider(create: (_) => FavouritesController()),
//         ChangeNotifierProvider(create: (_) => AllNearShopsAsPerPincode()),
//         ChangeNotifierProvider(create: (_) => ShopProfileViewController()),
//         ChangeNotifierProvider(create: (_) => AllShopController()),
//         ChangeNotifierProvider(create: (_) => AllCategoryShopController()),
//         ChangeNotifierProvider(create: (_) => ProductCategoryController()),
//         ChangeNotifierProvider(create: (_) => ShopAllSeasonalController()),
//         ChangeNotifierProvider(create: (_) => EditAdminProductController()),
//         ChangeNotifierProvider(create: (_) => ProductViewController()),
//         ChangeNotifierProvider(create: (_) => SCustomerListController()),
//         ChangeNotifierProvider(create: (_) => SAllRecommandedProductsController()),
//         ChangeNotifierProvider(create: (_) => ShopEditProfileDetailController()),
//         ChangeNotifierProvider(create: (_) => SCustomerDetailController()),
//         ChangeNotifierProvider(create: (_) => DeliveryAddressController()),
//         ChangeNotifierProvider(create: (_) => AddAddressController()),
//         ChangeNotifierProvider(create: (_) => SCouponsListController()),
//         ChangeNotifierProvider(create: (_) => EditCustomProductController()),
//         ChangeNotifierProvider(create: (_) => SAddCouponsController()),
//         ChangeNotifierProvider(create: (_) => CartListController()),
//         ChangeNotifierProvider(create: (_) => CartDetailController()),
//         ChangeNotifierProvider(create: (_) => AllOffersController()),
//         ChangeNotifierProvider(create: (_) => OrderSummaryController()),
//         ChangeNotifierProvider(create: (_) => OrderPaymentController()),
//         ChangeNotifierProvider(create: (_) => MyOrdersController()),
//         ChangeNotifierProvider(create: (_) => ShopOwnerOrderViewController()),
//         ChangeNotifierProvider(create: (_) => CustomerOrderViewController()),
//         ChangeNotifierProvider(create: (_) => TrackOrderStatusController()),
//         ChangeNotifierProvider(create: (_) => ShopSettingController()),
//         ChangeNotifierProvider(create: (_) => CmsController()),
//         ChangeNotifierProvider(create: (_) => shopPromotionController()),
//         ChangeNotifierProvider(create: (_) => PaymentHistoryController()),
//         ChangeNotifierProvider(create: (_) => SGetTicketListController()),
//         ChangeNotifierProvider(create: (_) => ShopViewTicketController()),
//         ChangeNotifierProvider(create: (_) => ShopViewTicketController()),
//         ChangeNotifierProvider(create: (_) => SubscriptionHistoryController()),
//         ChangeNotifierProvider(create: (_) => ShopSeasonalRecommandedOfferProductsController()),
//         ChangeNotifierProvider(create: (_) => ShopSeasonalRecommandedOfferProductsController()),
//         ChangeNotifierProvider(create: (_) => SBankAccountController()),
//         ChangeNotifierProvider(create: (_) => SGetProductUnitListController()),
//         ChangeNotifierProvider(create: (_) => CustomerSettingController()),
//         ChangeNotifierProvider(create: (_) => AddEditUnitController()),
//         ChangeNotifierProvider(create: (_) => ShopNoticationController()),
//         ChangeNotifierProvider(create: (_) => TicketController()),
//         ChangeNotifierProvider(create: (_) => GetTicketListController()),
//         ChangeNotifierProvider(create: (_) => CustomerReviewListControler()),
//         ChangeNotifierProvider(create: (_) => CustomerNoticationController()),
//         ChangeNotifierProvider(create: (_) => customerAdscontroller()),
//         ChangeNotifierProvider(create: (_) => BottomNavigationController()),
//         ChangeNotifierProvider(create: (_) => CAllCouponController()),
//         ChangeNotifierProvider(create: (_) => ReturnOrderController()),
//         ChangeNotifierProvider(create: (_) => PaymentRefundListController()),
//         ChangeNotifierProvider(create: (_) => SShopReviewListController()),
//       ],
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// var fcmToken;

// final firebaseMessaging = FirebaseMessaging.instance;

// class _MyAppState extends State<MyApp> {
//   @override

//   void initState() {
//     Future<void> initNotification(context) async {
// // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//       const AndroidInitializationSettings initializationSettingsAndroid =
//           AndroidInitializationSettings('mipmap/ic_launcher');
//       final IOSInitializationSettings initializationSettingsIOS =
//           IOSInitializationSettings();
//       final MacOSInitializationSettings initializationSettingsMacOS =
//           MacOSInitializationSettings();
//       final InitializationSettings initializationSettings =
//           InitializationSettings(
//               android: initializationSettingsAndroid,
//               iOS: initializationSettingsIOS,
//               macOS: initializationSettingsMacOS);
//       await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//           onSelectNotification: (String? payload) {
//         print("nnnnnnnnnnnnnnnnnn");

//         print(payload);
//         var res = jsonDecode(payload.toString());
//         print(res["data"]["user_type"]);
//         if (res["data"] == "shop_owner") {
//           context
//               .read<SMainScreenController>()
//               .onOrderTypeNotification(context, res["data"]["redirect_id"]);
//         }
//         if (res["data"] == "customer") {
//           context
//               .read<MainScreenController>()
//               .onOrderTypeNotification(context, res["data"]["redirect_id"]);
//         }
//         print("lllllllllllllllllllll");
//         if (payload != null) OpenFile.open(payload);
//       });
//     }

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
//       print(message.data);
//       print("onMessageOpenedApp: $message");
//       print("okkkkk");

//       ////////////Shop Notification Navigation /////////////////////
//       print(message.data["notification_type"]);
//       if (message.data["notification_type"] == "custom") {
//         context.read<SMainScreenController>().onCustomTypeNotification(context);
//       }
//       if (message.data["notification_type"] == "order") {
//         context
//             .read<SMainScreenController>()
//             .onOrderTypeNotification(context, message.data["redirect_id"]);
//       }
//     });

//     FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
//       print("onBackgroundMessage: $message");
//     });

//     // fireBaseApi();
//   }

//   Future<void> _showNotification(fileName, savePath) async {
//     final android = AndroidNotificationDetails('0', 'Adun Accounts',
//         channelDescription: 'channel description',
//         importance: Importance.max,
//         icon: '');
//     final iOS = IOSNotificationDetails();
//     final platform = NotificationDetails(android: android, iOS: iOS);

//     await flutterLocalNotificationsPlugin.show(
//         0, // notification id
//         "${fileName}",
//         'Download complete.',
//         platform,
//         payload: '$savePath');
//   }

//   void fireBaseApi() async {
//     await firebaseMessaging.requestPermission();

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
//       print("onMessageOpenedApp: $message");
//     });
//     FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
//       print("onBackgroundMessage: $message");
//     });
//   }

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
//       statusBarColor: Colors.transparent,
//     ));
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     return ScreenUtilInit(
//         useInheritedMediaQuery: true,
//         designSize: const Size(360, 690),
//         minTextAdapt: true,
//         splitScreenMode: true,
//         builder: (context, child) {
//           return Container(
//               alignment: Alignment.center,
//               child: Directionality(
//                 textDirection: TextDirection.ltr,
//                 child: LoadingOverlay(
//                   child: MaterialApp(
//                     title: 'Flutter Demo',
//                     theme: ThemeData(
//                       primarySwatch: Colors.blue,
//                       fontFamily: 'dm_sans_regular',
//                     ),
//                     debugShowCheckedModeBanner: false,
//                     home: SplashScreen(),
//                     // initialRoute: '/',
//                     //   routes: {
//                     //       '/':(context)=>SplashScreen(),

//                     //   },
//                   ),
//                 ),
//               ));
//         });
//   }
// }