import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/cart/model/add_product_to_cart_model.dart';
import 'package:local_supper_market/screen/customer/cart/repository/add_product_to_cart_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/add_fav_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/remove_fav_shop_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/add_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/remove_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/order_summary/model/c_apply_coupon_model.dart';
import 'package:local_supper_market/screen/customer/order_summary/model/order_summary_model.dart';
import 'package:local_supper_market/screen/customer/order_summary/repository/apply_coupon_repo.dart';
import 'package:local_supper_market/screen/customer/order_summary/repository/order_summary_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderSummaryController extends ChangeNotifier {
  OrderSummaryRepo orderSummaryRepo = OrderSummaryRepo();
  RemoveFavShopRepo removeFavShopRepo = RemoveFavShopRepo();
  AddFavShopRepo addFavShopRepo = AddFavShopRepo();
  AddProductToCartRepo addProductToCartRepo = AddProductToCartRepo();
  ApplyCouponRepo applyCouponRepo = ApplyCouponRepo();

  RemoveFavReqModel get removeFavReqModel => RemoveFavReqModel(
        shopId: shopId.toString(),
      );
  TextEditingController expectedDateController=TextEditingController();
  String shopId = "";
  String cartId = "";
  String groupValue = "deliveryTo";
  ShopDetails? shopDetailData;
  ShopDeliveryTypes? shopDeliveryTypes;
  List? shopDeliverySlots;
  OrderFinalTotals? orderFinalTotals;
  List<CustomerAddress>? customerAddress;
  List<CartItemList>? cartItemList;
  List<FinalCouponList>? finalCouponList;
  List<FullFillYourCraving>? fullFillYourCravings;
  bool isLoading = true;
  bool favAllShop = true;
  List<bool> defaultSelectedAddress = [];
  String slotGroupValue="";
  String offerGroupValue="";
  String addressGroupValue="";
  bool isNotFilled=false;
  String couponDiscount="";
  String deliveryCharges="";
  String productTotalDiscount="";
  String subTotal="";
  String total="";
  String totalDiscount="";
  TextEditingController couponCodeController=TextEditingController();





  Future<void> initState(context, cId, id,refresh) async {
    if(refresh) {
      groupValue = "deliveryTo";
      await getOrderSummary(context, cId, id);
    }
    }

  void showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  void onExpectedDateSelected(value){
    expectedDateController.text=value;
    notifyListeners();
  }

  void onRadioButtonSelected(value) {
    groupValue = value;
    notifyListeners();
  }



  void onDeliverySlotSelected(value){
    slotGroupValue=value;
    notifyListeners();
  }

  void onOfferSelected(value,context,discount)async{
    offerGroupValue=value.toString();
    couponDiscount=discount;
    await applyCoupon(context);
    notifyListeners();
  }


  void onAddressSelected(value){
    addressGroupValue=value;
    notifyListeners();
  }
  OrderSummaryReqModel get orderSummeryRequestModel =>
      OrderSummaryReqModel(shopId: shopId, cartId: cartId);

  Future<void> getOrderSummary(context, id, cId) async {
    showLoader(true);
    shopId = id.toString();
    cartId = cId.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    orderSummaryRepo
        .viewOrderSummery(
            orderSummeryRequestModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = OrderSummaryResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if (result.orderSummaryData?.shopDeliveryTypes?.shopOwnerCustomerPickup == "active") {
          groupValue = "selfPickup";
        } else {
          groupValue = "deliveryTo";
        }
        shopDetailData = result.orderSummaryData?.shopDetails;
        shopDeliverySlots = result.orderSummaryData?.shopDeliverySlots;
        orderFinalTotals = result.orderSummaryData?.orderFinalTotals;
      deliveryCharges= orderFinalTotals?.deliveryCharges??"";
      productTotalDiscount= orderFinalTotals?.productTotalDiscount.toString()??"";
      subTotal= orderFinalTotals?.subTotal.toString()??"";
      total= orderFinalTotals?.total.toString()??"";
      totalDiscount= orderFinalTotals?.totalDiscount.toString()??"";
      customerAddress = result.orderSummaryData?.customerAddresses;
        int addressListLength=customerAddress?.length??0;
        for(int i=0;i<addressListLength;i++){
          if(customerAddress?[i].deliveryAddressIsDefault=="yes"){
            addressGroupValue=customerAddress?[i].addressId.toString()??"";
          }
        }
        cartItemList = result.orderSummaryData?.cartItemList;
        finalCouponList = result.orderSummaryData?.finalCouponList;
        fullFillYourCravings = result.orderSummaryData?.fullFillYourCravings;
        showLoader(false);
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

  void launchPhone(String mobNumber, context) async {
    var number = Uri.parse("tel:${mobNumber}");
    if (await canLaunchUrl(number)) {
      await launchUrl(number);
    } else {
      Utils.showPrimarySnackbar(context, "Unable to dial at the moment",
          type: SnackType.error);
    }
  }

  Future<void> removeAllShopFavList(context, id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    removeFavShopRepo
        .updateRemoveFavShop(removeFavReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = RemoveFavResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        favAllShop = false;
        print("hello");
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
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

  AddFavReqModel get addFavReqModel => AddFavReqModel(
        shopId: shopId.toString(),
      );

  Future<void> updateAllShopFavList(context, id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    addFavShopRepo
        .updateAddFavShop(addFavReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = AddFavResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        favAllShop = true;
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
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

  Future<void> addToCart(pType, pId, sId, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    addProductToCartRepo
        .addProductToCart(
            AddProductToCartReqModel(
                productType: pType,
                productUnitId: pId.toString(),
                shopId: sId.toString(),
                quantity: "1"),
            pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result =
          AddProductToCartResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
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

  CustomerApplyCouponsRequestModel get customerApplyCouponsRequestModel=>CustomerApplyCouponsRequestModel(
    shopId: shopId,
    couponId: offerGroupValue,
    cartId: cartId,
    couponDiscount: couponDiscount,
    deliveryCharges: orderFinalTotals?.deliveryCharges,
    productTotalDiscount: orderFinalTotals?.productTotalDiscount.toString(),
    subTotal: orderFinalTotals?.subTotal.toString(),
    total: orderFinalTotals?.total.toString(),
    totalDiscount: orderFinalTotals?.totalDiscount.toString(),
  );

  Future<void> applyCoupon(context)async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    applyCouponRepo
        .applyCoupon(customerApplyCouponsRequestModel,pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = CustomerApplyCouponsResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        final data=result.applyCouponData;
        couponCodeController.text=data?.couponCode.toString()??"";
        deliveryCharges=data?.deliveryCharges.toString()??"";
        subTotal=data?.subTotal??"";
        total=data?.total??"";
        totalDiscount=data?.totalDiscount??"";

       Navigator.pop(context);
       Utils.showPrimarySnackbar(context, result.message,
           type: SnackType.success);
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
