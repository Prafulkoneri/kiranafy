// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:local_supper_market/utils/url/model/get_url_model.dart';
// import 'package:local_supper_market/utils/url/repository/get_url_repo.dart';
// import 'package:local_supper_market/utils/utils.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class GetUrlController extends ChangeNotifier{
//   // String ? baseUrl;
//   // GetUrlRepo getUrlRepo=GetUrlRepo();
// bool isLoading=true;
//   showLoader(value){
//     isLoading=value;
//     notifyListeners();
//   }
//
//   GetUrlReqModel get getUrlReqModel=>GetUrlReqModel(
//       appKey:"%LocalSuperMart*app#key%"
//       );
//
//   Future<void> getSubscriptionPlanDetails(context) async {
//     showLoader(true);
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     print(pref.getString("successToken"));
//     getUrlRepo
//         .getUrl(getUrlReqModel)
//         .then((response) {
//       print("successToken");
//       final result = GetUrlResModel.fromJson(jsonDecode(response.body));
//       print(response.statusCode);
//       if (response.statusCode == 200) {
//       baseUrl=result.data?.appUrl;
//       notifyListeners();
//       } else {
//         Utils.showPrimarySnackbar(context, result.message,
//             type: SnackType.error);
//       }
//     }).onError((error, stackTrace) {
//       Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
//     }).catchError(
//           (Object e) {
//         Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
//       },
//       test: (Object e) {
//         Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
//         return false;
//       },
//     );
//   }
//
// }