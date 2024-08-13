part of 'cartbloc_bloc.dart';


@immutable
abstract class CartEvent extends Equatable{}
class AddtoCartEvent extends CartEvent{
  Product product;
  double totalPrice=0;
  AddtoCartEvent({required this.product,required this.totalPrice});

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