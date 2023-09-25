import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/help_center/model/ticket_reply_view.dart';
import 'package:local_supper_market/screen/shop_owner/help_center/model/view_ticket_model.dart';
import 'package:local_supper_market/screen/shop_owner/help_center/repository/ticket_reply_repo.dart';
import 'package:local_supper_market/screen/shop_owner/help_center/repository/view_ticket_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopViewTicketController extends ChangeNotifier {
  bool isLoading = true;
  String ticketId = "";
  String ticketRemark = "";
  String ticketStatus = "";
  TextEditingController remarkController = TextEditingController();
  TicketDetails? ticketDetails;
  List<TicketRepliesList>? ticketRepliesList;
  ViewTicketData? viewTicketData;
  ReplyData? reply;

  ViewTicketRepo viewTicketRepo = ViewTicketRepo();
  TicketReplyRepo ticketReplyRepo = TicketReplyRepo();

  Future<void> initState(context, tID) async {
    await viewTicketList(context, tID);
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  ViewTicketRequestModel get viewTicketRequestModel =>
      ViewTicketRequestModel(ticketId: ticketId);

  Future<void> viewTicketList(context, tID) async {
    ticketId = tID;
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    viewTicketRepo
        .viewTicket(viewTicketRequestModel, pref.getString("successToken"))
        .then((response) {
      print("66666");
      log(response.body);
      print("66666");
      final result = ViewTicketResModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        viewTicketData = result.viewTicketData;
        ticketDetails = viewTicketData?.ticketDetails;
        ticketRepliesList = viewTicketData?.ticketRepliesList;
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
  ////////////////REPLY TICKET//////////////////////

  TicketReplyRequestModel get ticketReplyRequestModel =>
      TicketReplyRequestModel(
        ticketId: ticketDetails?.id.toString(),
        ticketRemark: remarkController.text,
        ticketStatus: ticketDetails?.ticketStatus,
        type: "",
      );

  Future<void> ticketReply(
    context,
  ) async {
    // ticketId = tID;
    // ticketRemark = tRemark;
    // ticketStatus = tStatus;
    // showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    ticketReplyRepo
        .replyTicket(ticketReplyRequestModel, pref.getString("successToken"))
        .then((response) {
      final result = TicketReplyResModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        viewTicketList(context, ticketId);
        remarkController.clear();
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
}
