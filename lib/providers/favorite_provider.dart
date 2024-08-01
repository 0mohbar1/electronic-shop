import 'package:electronic_shop/data/models/apishopping.dart';
import 'package:flutter/cupertino.dart';

class FavoriteProvider extends ChangeNotifier{
  late ApiShopping product;
  bool isFav=false;
  void changeFavProduct(){
   isFav=!isFav;
   notifyListeners();
  }
}