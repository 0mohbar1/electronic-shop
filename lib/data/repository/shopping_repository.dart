import 'package:electronic_shop/data/web_services/shopping_web_services.dart';

import '../models/apishopping.dart';

class StoreShoppingRepository{
  final StoreShoppingWebServices storeShoppingWebServices;

  StoreShoppingRepository(this.storeShoppingWebServices);
  Future<List<ApiShopping>> getAllItem()async{
    final storeItem=await storeShoppingWebServices.getAllItemStore();
    return storeItem.map((storeItem) => ApiShopping.fromJson(storeItem)).toList();
  }
}