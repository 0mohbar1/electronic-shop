part of 'cartbloc_bloc.dart';


class CartState extends Equatable {
  List<ApiShopping> products;
  CartState({ this.products=const []});
  @override
  List<Object> get props=>[products];
}