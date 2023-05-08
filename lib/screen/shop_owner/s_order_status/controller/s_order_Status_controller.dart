import 'package:flutter/material.dart';

class SOrderStatusController extends ChangeNotifier{

  int selectedIndex=0;

  void onTabClicked(index){
    selectedIndex=index;
    notifyListeners();
  }

}
