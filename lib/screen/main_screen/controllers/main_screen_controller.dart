import 'package:flutter/cupertino.dart';
import 'package:intellect_flutter/screens/chat_list/views/chat_list_screen_view.dart';
import 'package:intellect_flutter/screens/dashboard/controllers/dash_board_controller.dart';
import 'package:intellect_flutter/screens/dashboard/views/dash_board_view.dart';
import 'package:intellect_flutter/screens/my_connect/views/my_connect_screen_view.dart';
import 'package:intellect_flutter/screens/profile/views/profile_screen_view.dart';
import 'package:intellect_flutter/screens/search/views/search_screen_view.dart';
import 'package:intellect_flutter/screens/view_all/views/view_all_screen_view.dart';

class MainScreenController extends ChangeNotifier {
  int currentIndex = 0;
  int currentTab = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = DashBoardView();

  void onBottomNavChanged(index) {
    currentIndex = index;
    notifyListeners();
  }

  // void onFabIconPressed() {
  //   currentTab = 4;
  //   currentScreen=ChatListScreenView();
  //   print(currentIndex);
  //   notifyListeners();
  // }

  void onDashboardPressed() {
    currentTab = 0;
    currentScreen = DashBoardView();
    notifyListeners();
  }

  void onViewAllPressed(){
    currentTab=0;
    currentScreen=ViewAllScreenView();
    notifyListeners();
  }

  void onViewAllScreenBackButtonPressed(){
    currentTab=0;
    currentScreen=DashBoardView();
    notifyListeners();
  }

  void onSearchPressed() {
    currentTab = 1;
    print(currentTab);
    currentScreen = SearchScreenView();
    notifyListeners();
  }

  void onMyConnectPressed(){
    currentTab=2;
    currentScreen=MyConnectScreenView();
    notifyListeners();
  }

  void onProfilePressed(){
    currentTab=3;
    currentScreen=ProfileScreenView();
    notifyListeners();
  }

  void onChatPressed(){
    currentTab=4;
    currentScreen=ChatListScreenView();
    notifyListeners();
  }



}
