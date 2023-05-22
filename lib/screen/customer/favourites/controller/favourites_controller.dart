import 'package:flutter/cupertino.dart';

class FavouritesController extends ChangeNotifier{
  bool isFavShopPressed=true;



  onFavouriteShopTapped(){
    isFavShopPressed=true;
    notifyListeners();
  }
  onFavouriteProductTapped(){
    isFavShopPressed=false;
    notifyListeners();
  }
}