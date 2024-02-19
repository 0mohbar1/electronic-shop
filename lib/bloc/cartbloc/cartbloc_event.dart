part of 'cartbloc_bloc.dart';


@immutable
abstract class CartEvent {}
class AddtoCartEvent extends CartEvent{
  ApiShopping product;
  AddtoCartEvent({required this.product});
}