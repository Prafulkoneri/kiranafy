import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/help_center/repository/create_ticket_repo.dart';
import 'package:local_supper_market/screen/customer/help_center/repository/get_ticket_list_repo.dart';
import 'package:local_supper_market/screen/customer/help_center/view/raise_ticket_form.dart';
import 'package:local_supper_market/screen/on_boarding/view/on_boarding_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/customer_list/model/customer_fav_model.dart';
import 'package:local_supper_market/screen/shop_owner/customer_list/model/customer_list_model.dart';
import 'package:local_supper_market/screen/shop_owner/customer_list/repository/customer_fav_repo.dart';
import 'package:local_supper_market/screen/shop_owner/customer_list/repository/customer_list_repo.dart';
import 'package:local_supper_market/screen/shop_owner/help_center/model/create_ticket_model.dart';
import 'package:local_supper_market/screen/shop_owner/help_center/model/get_ticket_list_model.dart';
import 'package:local_supper_market/screen/shop_owner/help_center/model/ticket_type_model.dart';
import 'package:local_supper_market/screen/shop_owner/help_center/repository/create_ticket_repo.dart';
import 'package:local_supper_market/screen/shop_owner/help_center/repository/get_ticket_list_repo.dart';
import 'package:local_supper_market/screen/shop_owner/help_center/repository/ticket_type_repo.dart';
import 'package:local_supper_market/screen/shop_owner/help_center/view/help_center_view.dart';
import 'package:local_supper_market/screen/shop_owner/help_center/view/raise_ticket_form.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/model/shop_edit_profile_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/repository/shop_edit_profile_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/view/s_edit_profile_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/view/s_shop_configuration_view.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class GetTicketListController extends ChangeNotifier {
  CustomerTicketListRepo cticketListRepo = CustomerTicketListRepo();
  TicketTypeRepo ticketTypeRepo = TicketTypeRepo();
  CustomerCreateTicketRepo createTicketRepo = CustomerCreateTicketRepo();
  TextEditingController subjectController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<TicketTypeData>? ticketTypeData;
  int ticketTypeId = 0;
  bool isLoading = true;
  String description = ""; //
  bool isTickedError = false;
  String errorMsgForRaiseTicket = "";

  List<TicketListData>? ticketList;
  Future<void> initState(context) async {
    await getTicketList(context);
    await getTicketTypeList(context);
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  void onOpenBottomSheet(context) {
    ticketTypeId = 0;
    subjectController.clear();
    descriptionController.clear();
    showModalBottomSheet(
        backgroundColor: Colors.white,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          // using a scaffold helps to more easily position the FAB
          return RaiseTicketView();
        });
    notifyListeners();
  }

  Future<void> onTicketTypeSelected(value) async {
    ticketTypeId = int.parse(value.toString());
    notifyListeners();
  }

  Future<void> getTicketList(context) async {
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    cticketListRepo
        .cticketList(pref.getString("successToken"))
        .then((response) {
      print("5555555555555555555555555555555555555");
      print(response.body);
      print("5555555555555555555555555555555555555");
      final result = GetTicketListModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        ticketList = result.ticketList;
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

  ////////////////////////////////Ticket Type/////////////////////////////
  Future<void> getTicketTypeList(context) async {
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    ticketTypeRepo.ticketType(pref.getString("successToken")).then((response) {
      print(response.body);
      final result = TicketTypeModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        ticketTypeData = result.ticketTypeData;
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

  ////////////////////////Cteate Ticket////////////////////
  CreateTicketRequestModel get createTicketRequestModel =>
      CreateTicketRequestModel(
        ticketTypeId: ticketTypeId.toString(),
        description: descriptionController.text,
        subject: subjectController.text,
      );

  Future<void> createTicket(
    context,
  ) async {
    if (ticketTypeId == 0) {
      isTickedError = true;
      errorMsgForRaiseTicket = "Select Ticket Type";
      notifyListeners();
      Timer(Duration(seconds: 3), () async {
        isTickedError = false;
        notifyListeners();
      });

      return;
    }
    if (subjectController.text == "") {
      isTickedError = true;
      errorMsgForRaiseTicket = "Enter Subject";
      notifyListeners();
      Timer(Duration(seconds: 3), () async {
        isTickedError = false;
        notifyListeners();
      });
      return;
    }
    if (descriptionController.text == "") {
      isTickedError = true;
      errorMsgForRaiseTicket = "Enter Description";
      notifyListeners();
      Timer(Duration(seconds: 3), () async {
        isTickedError = false;
        notifyListeners();
      });
      return;
    }
    LoadingOverlay.of(context).show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    createTicketRepo
        .createTicket(createTicketRequestModel, pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result = CreateTicketResModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        getTicketList(context);
        LoadingOverlay.of(context).hide();
        Navigator.pop(context);
        ticketTypeId = 0;
        descriptionController.clear();
        subjectController.clear();
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);

        // ticketRepliesList?.insert(ticketRepliesList?.length??0,{"id":1,"remark":"bve","created_at":,"name":,"profile_image_path":,"profile_image_name":});
        // ticketRepliesList?.insert(ticketRepliesList?.length??0,reply);
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

  showTicketErrorMsg() {
    isTickedError = true;
    notifyListeners();
    print(isTickedError);
  }

  void onTicketDissmis() {
    isTickedError = false;
    notifyListeners();
  }
}
