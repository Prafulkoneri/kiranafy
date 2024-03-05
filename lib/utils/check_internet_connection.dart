

// import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
// import 'package:local_supper_market/utils/utils.dart';
// import 'package:provider/provider.dart';

// class CheckInternetConnection{
//   Future<void> checkInternet(context)async{
//     try {
//       final result = await InternetAddress.lookup('example.com');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         print('connected');
//       }
//     } on SocketException catch (_) {
//       print("not connected");
//       final read=Provider.of<SMainScreenController>(context,listen: false);
//       read.onNavigation(0,Utils().showNoInternetDialog(context), context);
//       read.hideBottomNavigationBar();
//     }
//   }
// }
