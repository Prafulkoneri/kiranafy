import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/customer_list/model/customer_list_model.dart';
import 'package:local_supper_market/screen/shop_owner/customer_list/repository/customer_list_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SCustomerListController extends ChangeNotifier {
  CustomerListData? customerListData;
  // List<CustomerDetail>? customerDetail;
  // CustomerListData? customerListData;//
  List<AllCustomerListElement>? customerList; //
  List<AllCustomerListElement>? favouriteToShopsList; //
  List<AllCustomerListElement>? orderedButNotFavouriteList; //
  CustomerListRepo customerListRepo = CustomerListRepo();
  // CustomerFavListRepo customerFavListRepo = CustomerFavListRepo();
  bool isFavToShopSelected = false;
  bool isOrderedSelected = false;
  bool isLoading = true;

  Future<void> initState(context, isRefresh, pageName) async {
    isFavToShopSelected = false;
    isOrderedSelected = false;
    if (isRefresh) {
      await getCustomerList(context, pageName);
    }
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getCustomerList(context, pageName) async {
    if (pageName == "dashboardProduct") {
      isOrderedSelected = true;
    }
    if (pageName == "dashboardFavCustomer") {
      isFavToShopSelected = true;
    }
    if (pageName == "account") {
      isFavToShopSelected = false;
      isOrderedSelected = false;
    }
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    customerListRepo
        .customerListRepo(pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result = CustomerListModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        customerListData = result.customerListData;
        if (!isFavToShopSelected && !isOrderedSelected) {
          customerList = customerListData?.allCustomerList;
        }
        if (isFavToShopSelected) {
          customerList = customerListData?.favouriteToShopsList;
          if (pageName == "filter") {
            Navigator.pop(context);
          }
        }
        if (isOrderedSelected) {
          customerList = customerListData?.orderedButNotFavouriteList;
          if (pageName == "filter") {
            Navigator.pop(context);
          }
        }
        // favouriteToShopsList =
        // orderedButNotFavouriteList =
        //     customerListData?.orderedButNotFavouriteList;

        showLoader(false);
        notifyListeners();
      }
      else if(response.statusCode == 401){
        Utils().logoutUser(context);
      }
      else {
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

  void onFavToShopSelected(value) {
    if (!isFavToShopSelected) {
      isFavToShopSelected = true;
      isOrderedSelected = false;
    } else {
      isFavToShopSelected = false;
      isOrderedSelected = false;
    }
    notifyListeners();
  }

  void onOrderedButNotFavSelected(value) {
    if (!isOrderedSelected) {
      isOrderedSelected = true;
      isFavToShopSelected = false;
    } else {
      isFavToShopSelected = false;
      isOrderedSelected = false;
    }
    notifyListeners();
  }
}
