import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

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

import 'package:local_supper_market/screen/shop_owner/s_order_status/controller/s_order_Status_controller.dart';

import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/controller/s_edit_admin_product_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/controller/s_edit_custom_product_controller.dart';

import 'package:local_supper_market/screen/shop_owner/s_select_category/controller/s_select_category_controller.dart';

import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/controller/s_shop_configuration_controller.dart';

import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/controller/s_subscription_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/view/s_subscription_view.dart';

import 'package:local_supper_market/screen/splash/controller/splash_controller.dart';
import 'package:local_supper_market/screen/splash/view/splash_view.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'screen/customer/cart/controller/cart_controller.dart';
import 'screen/customer/cart/controller/cart_detail_controller.dart';
import 'screen/customer/delivery_address/controller/delivery_address_controller.dart';
import 'screen/customer/near_shops/controller/all_near_shop_controller.dart';
import 'screen/customer/products/controller/product_view_controller.dart';
import 'screen/customer/profile/controller/edit_profile_controller.dart';
import 'screen/customer/shop_profile/controller/recommanded_controller.dart';
import 'screen/customer/shop_profile/controller/all_seasonal_controller.dart';
import 'screen/shop_owner/s_coupons/controller/shop_coupons_list_controller.dart';
import 'screen/shop_owner/s_kyc_verification/view/s_kyc_verification_view.dart';
import 'screen/shop_owner/s_products/controller/s_add_product_controller.dart';
import 'screen/shop_owner/s_products/controller/s_custom_product_controller.dart';
import 'screen/shop_owner/s_products/controller/s_selected_product_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseMessaging.instance.getToken().then((newToken) {
      fcmToken = newToken;
      print("fcmToken${fcmToken}");
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
          return MaterialApp(
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
              home: SplashScreen());
        });
  }
}
