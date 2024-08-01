part of 'cartbloc_bloc.dart';


@immutable
abstract class CartEvent extends Equatable{}
class AddtoCartEvent extends CartEvent{
  ApiShopping product;
  AddtoCartEvent({required this.product});

  @override
  List<Object?> get props => [product];
}
class BuyOneItem extends CartEvent{
  int? id;

  BuyOneItem(this.id);

  @override
  List<Object?> get props => [id];
}
class BuyAllItem extends CartEvent{

  @override
  List<Object?> get props => [];
}