import 'package:flutter/cupertino.dart';
import 'package:local_supper_market/widget/bottom_bar/persistent_tab_view.dart';

class BottomNavigationController extends ChangeNotifier{

  PersistentTabController  bottomBarcontroller = PersistentTabController(initialIndex: 0);

  void changeBottomNavIndex(index){
    bottomBarcontroller.index=index;
    notifyListeners();
  }
}