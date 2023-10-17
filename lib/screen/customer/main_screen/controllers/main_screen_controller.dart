import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:local_supper_market/screen/customer/cart/view/cart_screen_view.dart';
import 'package:local_supper_market/screen/customer/coupons/couponsall.dart';
import 'package:local_supper_market/screen/customer/delivery_view/view/order_view.dart';
import 'package:local_supper_market/screen/customer/home/controller/home_screen_controller.dart';
import 'package:local_supper_market/screen/customer/home/view/home_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/model/set_pincode_model.dart';
import 'package:local_supper_market/screen/customer/main_screen/repository/set_pincode_repo.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/notifications/view/notification_view.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:local_supper_market/utils/maps/view/map_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../account/view/profile_screen_view.dart';
import '../../near_shops/view/all_near_shops_view.dart';

class MainScreenController extends ChangeNotifier {
  int currentIndex = 0;
  int currentTab = 0;
  bool stackLoaderVisible = false;
  SetPincodeRepo setPincodeRepo = SetPincodeRepo();
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreenView(
    refreshPage: false,
  );
  bool isLocationServiceEnabled = false;
  bool isPincodeSnackBarVisible = false;
  String lat = "";
  String lng = "";
  String message = "";
  bool isFirstLoad = true;
  LatLng defaultLatLng = LatLng(18.5679, 73.9143);
  String cityName = "";
  String areaName = "";
  bool locationNotFound = false;
  bool isLocationFound = false;
  String locationErrorMessage = "";
  bool hideBottomNavigation = false;
  int cartCount = 0;
  RemoteMessage ? notificationMessage;
  bool isInititalNotification=false;

  void initState(context, index, currentScreen) async {
    // navigation(index, currentScreen);
    if (isFirstLoad) {
      showMap(context, true);
    }
    isFirstLoad = false;
    notifyListeners();
  }

  onNavigation(index, screen, context) {
    currentScreen = screen;
    currentTab = index;
    notifyListeners();
  }

  void getCartCount() {}

  onSignOut() {
    currentTab = 0;
    isFirstLoad = true;
    currentScreen = HomeScreenView(refreshPage: false);
    // notifyListeners();
  }

  void onInititalMessage(msg){
    isInititalNotification=true;
    notificationMessage=msg;
    notifyListeners();
  }



  void onBottomNavChanged(index) {
    currentIndex = index;
    notifyListeners();
  }

  showStackLoader(value) {
    stackLoaderVisible = value;
    notifyListeners();
  }

  // void onFabIconPressed() {
  //   currentTab = 4;
  //   currentScreen=ChatListScreenView();
  //   print(currentIndex);
  //   notifyListeners();
  // }

  void showMap(context, intialMapView) async {
    isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    print("hello");
    print(isLocationServiceEnabled);
    showModalBottomSheet(
      enableDrag: false,
      isDismissible: false,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async {
              print("hello");
              return true;
            },
            child: MapScreenView(
              isLocationEnabled: isLocationServiceEnabled,
              initialMapView: intialMapView,
              latLng: defaultLatLng,
            ));
      },
    );
    if (!isLocationServiceEnabled) {}
  }

  void onHomeScreenPressed() {
    currentTab = 0;
    currentScreen = HomeScreenView(
      refreshPage: false,
    );
    notifyListeners();
  }

  onOrderTypeNotification(context, id) {
    currentScreen = OrderDeliveryView(
      orderId: id.toString(),
      screenName: "main",
      isRefresh: true,
    );
    hideBottomNavigation = true;
    // Navigator.push(context,MaterialPageRoute(builder: (context)=> OrderDeliveryView(
    //   orderId: id.toString(),
    //   screenName: "main",
    //   isRefresh: true,
    // )));
    notifyListeners();
  }

  onCustomTypeNotification(context) {
    print("hello");
    currentScreen = CustomerNotificationsScreenView(isRefresh: true,route: "main",);
    hideBottomNavigation = false;
    notifyListeners();
  }

  showBottomNavigationBar() {
    hideBottomNavigation = false;
    notifyListeners();
  }

  hideBottomNavigationBar() {
    hideBottomNavigation = true;
    notifyListeners();
  }

  void onShopPressed() {
    currentTab = 1;
    currentScreen = AllNearShopsView(
      refreshPage: true,
      isSearchFocus: false,
    );
    notifyListeners();
  }

  void onMyCartPressed() {
    currentTab = 2;
    currentScreen = CartScreenView();
    notifyListeners();
  }

  void onOfferPressed() {
    currentTab = 3;
    currentScreen = AllCoupons();
    notifyListeners();
  }

  void onAccountPressed() {
    currentTab = 4;
    currentScreen = ProfileScreenView(
      isRefreshed: true,
    );
    notifyListeners();
  }

  Future<void> navigation(tabIndex, screenName) async {
    print("${tabIndex}tabIndex");
    currentTab = tabIndex;
    currentScreen = screenName;
    notifyListeners();
  }

  SetPincodeReqModel get setPincodeReqModel => SetPincodeReqModel(
        lng: lng,
        lat: lat,
      );

  Future<void> setPincode(context, locationEnabled, latitude, longitude) async {
    if (!locationEnabled) {
      return;
    }
    lat = latitude.toString();
    lng = longitude.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    setPincodeRepo
        .setPincode(setPincodeReqModel, pref.getString("successToken"))
        .then((response) {
      print("99999999");
      print(setPincodeReqModel.toJson());
      print("99999999");
      print(response.statusCode);
      log("response.body${response.body}");
      final result = SetPincodeResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if (result.status == 200) {
          isPincodeSnackBarVisible = true;
          message = result.message ?? "";
          cityName = result.data?.cityName ?? "";
          areaName = result.data?.areaName ?? "";
          defaultLatLng = LatLng(latitude, longitude);
          locationNotFound = false;
          locationErrorMessage = "";
          isLocationFound = true;

        } else {
          isLocationFound = false;
          locationErrorMessage = result.message ?? "";
          locationNotFound = true;
          notifyListeners();
          Timer(Duration(seconds: 3), () {
            print("duration");
            locationNotFound = false;
            notifyListeners();
          });
        }

        notifyListeners();
      } else if (response.statusCode == 401) {
        Utils().logoutUser(context);
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

  void onMapCloseBtnPressed(context) {
    if (!isLocationFound) {
      locationErrorMessage = "Select another location to continue";
      locationNotFound = true;
      notifyListeners();
      Timer(Duration(seconds: 3), () {
        locationNotFound = false;
        notifyListeners();
      });
    } else {
      if(isInititalNotification){
        print(notificationMessage?.data);
        if (notificationMessage?.data["notification_type"] == "custom") {
          onCustomTypeNotification(context);
        }
        else{
          onOrderTypeNotification(context,notificationMessage?.data["redirect_id"]);
        }
        isInititalNotification=false;
        Navigator.pop(context);
      }
      else {
        final read = Provider.of<HomeScreenController>(context, listen: false);
        read.initState(context, true);
        Navigator.pop(context);
      }
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => MainScreenView(
      //           index: 0,
      //           screenName: HomeScreenView(
      //             refreshPage: true,
      //           ))),
      //   (Route<dynamic> route) => false,
      // );
      notifyListeners();
    }
  }

  void onDismissTaped() {
    locationNotFound = false;
    locationErrorMessage = "";
    notifyListeners();
  }
}
